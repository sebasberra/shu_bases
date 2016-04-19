echo off
#
# NOTAS:
# 		instalar el rar y el vcron con el yast
#
#
# ------------------------------------------------------------------------
# ------------     dump de la estructura de la base     ------------------
# ------------------------------------------------------------------------
#
# --routines: Dump stored routines (procedures and functions) from the dumped databases
# --opt: The --opt option is enabled by default. This option is shorthand; it is the same as 
#	                  specifying --add-drop-table  --add-locks  --create-options  --disable-keys  
#                              --extended-insert  --lock-tables  --quick  --set-charset
# --add-drop-table: Add a DROP TABLE statement before each CREATE TABLE  statement
# --add-locks: Surround each table dump with LOCK TABLES and UNLOCK TABLES statements. 
#					This results in faster inserts when the dump file is reloaded
# --create-options: Include all MySQL-specific table options in the CREATE TABLE statements
# --disable-keys: For each table, surround the INSERT statements with /*!40000 ALTER TABLE tbl_name DISABLE KEYS */; 
#						and /*!40000 ALTER TABLE tbl_name ENABLE KEYS */; statements. 
#						This makes loading the dump file faster because the indexes are created after all rows are 
#						inserted. This option is effective only for non-unique indexes of MyISAM tables
# --extended-insert: esta en los comentarios del dump de datos
# --lock-tables: Lock all tables before dumping them. The tables are locked with READ LOCAL to allow concurrent 
#					inserts in the case of MyISAM tables. For transactional tables such as InnoDB and BDB, 
#						--single-transaction is a much better option, because it does not need to lock the tables at all
# --quick:	This option is useful for dumping large tables. It forces mysqldump to retrieve rows for a 
#				table from the server a row at a time rather than retrieving the entire row set and buffering it in 
#				memory before writing it out
# --set-charset: Add SET NAMES default_character_set  to the output. This option is enabled by default. 
#					To suppress the SET NAMES statement, use --skip-set-charset
# --triggers: Dump triggers for each dumped table. This option is enabled by default; 
#				disable it with --skip-triggers. This option was added in MySQL 5.0.11. 
#				Before that, triggers are not dumped. 
#
mysqldump -uroot -p --no-data --routines --skip-triggers diagnose >dump_estruct.sql
#
#
# dump solo de los triggers
#
mysqldump -uroot -p --no-data --no-create-info --triggers diagnose >dump_triggers.sql
#
#
#
# ------------------------------------------------------------------------
# --------------      dump de los datos de la base      ------------------
# ------------------------------------------------------------------------
#
# --no-create-info: Do not write CREATE TABLE  statements that re-create each dumped table
# --extended-insert: Use multiple-row INSERT  syntax that include several VALUES lists. 
#						This results in a smaller dump file and speeds up inserts when the file is reloaded
mysqldump -uroot -p --no-create-info --skip-extended-insert --skip-add-locks --skip-triggers diagnose >dump_data.sql
#
# ------------------------------------------------------------------------
# ------------                RAR                         ----------------
# ------------------------------------------------------------------------
#
# rar <command> -<switch 1> -<switch N> <archive> <files...>
#
# <command>
# a				Add files to archive
#
# <switch>
# ag[format]		Generate archive name using the current date
# df				Delete files after archiving
#
# comprime los dumps
rar a -ag_fYYYYMMDD_hHHMMSS -df dump_db_diagnose.rar dump_estruct.sql dump_triggers.sql dump_data.sql
#