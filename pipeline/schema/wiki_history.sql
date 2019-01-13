create table wiki_history
(
  id           serial
    constraint wiki_history_pk
      primary key,
  user_id      int,
  entry_id     int,
  edit_type    int,
  edit_time    timestamp with time zone,
  edit_comment varchar(1000)
);

create index wiki_history_user_id_edit_type_edit_time_entry_id_index
  on wiki_history (user_id, edit_type, edit_time, entry_id);


create function update_row_modified_function_() returns trigger
  language plpgsql
as
$$
BEGIN
  -- ASSUMES the table has a column named exactly "row_modified_".
  -- Fetch date-time of actual current moment from clock, rather than start of statement or start of transaction.
  NEW.row_last_modified = clock_timestamp();
  RETURN NEW;
END;
$$
;

create trigger row_mod_on_wiki_history_trigger_
  before insert or update
  on wiki_history
  for each row
execute procedure update_row_modified_function_()
;
