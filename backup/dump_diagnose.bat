ECHO OFF

REM ------------------------------------------------------------------------
REM ------------     dump de la estructura de la base     ------------------
REM ------------------------------------------------------------------------

REM --routines: Dump stored routines (procedures and functions) from the dumped databases
REM --opt: The --opt option is enabled by default. This option is shorthand; it is the same as 
REM	                  specifying --add-drop-table  --add-locks  --create-options  --disable-keys  
REM                              --extended-insert  --lock-tables  --quick  --set-charset
REM --add-drop-table: Add a DROP TABLE statement before each CREATE TABLE  statement
REM --add-locks: Surround each table dump with LOCK TABLES and UNLOCK TABLES statements. 
REM					This results in faster inserts when the dump file is reloaded
REM --create-options: Include all MySQL-specific table options in the CREATE TABLE statements
REM --disable-keys: For each table, surround the INSERT statements with /*!40000 ALTER TABLE tbl_name DISABLE KEYS */; 
REM						and /*!40000 ALTER TABLE tbl_name ENABLE KEYS */; statements. 
REM						This makes loading the dump file faster because the indexes are created after all rows are 
REM						inserted. This option is effective only for non-unique indexes of MyISAM tables
REM --extended-insert: esta en los comentarios del dump de datos
REM --lock-tables: Lock all tables before dumping them. The tables are locked with READ LOCAL to allow concurrent 
REM					inserts in the case of MyISAM tables. For transactional tables such as InnoDB and BDB, 
REM						--single-transaction is a much better option, because it does not need to lock the tables at all
REM --quick:	This option is useful for dumping large tables. It forces mysqldump to retrieve rows for a 
REM				table from the server a row at a time rather than retrieving the entire row set and buffering it in 
REM				memory before writing it out
REM --set-charset: Add SET NAMES default_character_set  to the output. This option is enabled by default. 
REM					To suppress the SET NAMES statement, use --skip-set-charset
REM --triggers: Dump triggers for each dumped table. This option is enabled by default; 
REM				disable it with --skip-triggers. This option was added in MySQL 5.0.11. 
REM				Before that, triggers are not dumped. 

mysqldump -uroot -p --no-data --routines --skip-triggers diagnose >dump_estruct.sql


REM dump solo de los triggers

mysqldump -uroot -p --no-data --no-create-info --triggers diagnose >dump_triggers.sql



REM ------------------------------------------------------------------------
REM --------------      dump de los datos de la base      ------------------
REM ------------------------------------------------------------------------

REM --no-create-info: Do not write CREATE TABLE  statements that re-create each dumped table
REM --extended-insert: Use multiple-row INSERT  syntax that include several VALUES lists. 
REM						This results in a smaller dump file and speeds up inserts when the file is reloaded
REM
REM
REM	--single-transaction:
REM
REM					Esta opción realiza un comando SQL BEGIN antes de volcar los datos del servidor. Es útil sólo con tablas 
REM					transaccionales tales como las InnoDB y BDB, ya que vuelca el estado consistente de la base de datos 
REM 				cuando se ejecuta BEGIN sin bloquear ninguna aplicación.
REM 				
REM 				Cuando use esta opción, debe tener en cuenta que sólo las tablas InnoDB se vuelcan en un estado consistente. 
REM					Por ejemplo, cualquier tabla MyISAM o HEAP volcadas mientras se usa esta opción todavía pueden cambiar de estado.
REM 				
REM 				La opción --single-transaction y la opción --lock-tables son mutuamente exclusivas, ya que LOCK TABLES provoca que 
REM 				cualquier transacción pendiente se confirme implícitamente.
REM 				
REM 				Para volcar tablas grandes, debe combinar esta opción con --quick.
REM
mysqldump -uroot -p --no-create-info --skip-extended-insert --skip-add-locks --skip-triggers --single-transaction --quick diagnose >dump_data.sql

REM ------------------------------------------------------------------------
REM ------------                RAR                         ----------------
REM ------------------------------------------------------------------------

REM rar <command> -<switch 1> -<switch N> <archive> <files...>

REM <command>
REM a				Add files to archive

REM <switch>
REM ag[format]		Generate archive name using the current date
REM df				Delete files after archiving

REM comprime los dumps
rar32.exe a -ag_fYYYYMMDD_hHHMMSS -df dump_db_diagnose.rar dump_estruct.sql dump_triggers.sql dump_data.sql
