create table "user"
(
	id integer not null
		constraint user_pkey
			primary key,
	username varchar(100) not null,
	nickname varchar(100),
	url varchar(200),
	avatar jsonb,
	sign varchar(200),
	user_group integer,
	row_last_modified timestamp with time zone not null
)
;

create unique index user_id_uindex
	on "user" (id)
;

create unique index user_username_uindex
	on "user" (username)
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
	on "user"
	for each row
	execute procedure update_row_modified_function_()
;

