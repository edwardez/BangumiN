create table subject
(
	id integer not null
		constraint subject_pk
			primary key,
	url varchar(200),
	type integer,
	name varchar(300),
	name_cn varchar(300),
	summary text,
	air_date date,
	air_weekday integer,
	rating jsonb,
	images jsonb,
	collection jsonb,
	rank integer,
	eps integer,
	eps_count integer,
	row_last_modified timestamp with time zone default clock_timestamp() not null,
	true_id integer
)
;

create unique index subject_id_uindex
	on subject (id)
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
	on subject
	for each row
	execute procedure update_row_modified_function_()
;

