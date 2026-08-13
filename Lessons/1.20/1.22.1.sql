NOTES :

CREATE TABLE : defines a new table and its COLUMNSTORE

you can scope it to a schema with schema_name.table_name

CREATE TABLE [IF NOT EXISTS] table_name (
    id_column INTEGER PRIMARY KEY,
    column_name2 datatype,
    column_name3 datatype,
    foreign key (FOREIGN_KEY_COLUMN) REFERENCES parent_table()
)