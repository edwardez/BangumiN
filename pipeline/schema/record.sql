create table record
(
	subject_id integer not null,
	user_id integer not null,
	username varchar(300) not null,
	nickname varchar(300) not null,
	subject_type integer not null,
	collection_status integer not null,
	add_date date not null,
	rate integer,
	tags varchar(1000) [],
	comment varchar(300),
	row_last_modified timestamp with time zone default clock_timestamp(),
	constraint record_pk
		primary key (subject_id, user_id)
)
;

alter table record owner to "g2JHc8nH4lCblvTCe"
;

create function update_row_modified_function_() returns trigger
	language plpgsql
as $$
BEGIN
  -- ASSUMES the table has a column named exactly "row_modified_".
  -- Fetch date-time of actual current moment from clock, rather than start of statement or start of transaction.
  NEW.row_last_modified = clock_timestamp();
  RETURN NEW;
END;
$$
;

create trigger row_mod_on_subject_trigger_
	before insert or update
	on record
	for each row
	execute procedure update_row_modified_function_()
;

