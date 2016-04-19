REM NOTA: debe crear la base de datos diagnose antes de ejecutar este script !!!

REM restaura la estructura
mysql -uroot -p diagnose <dump_db_diagnose.sql

REM restaura los datos
mysql -uroot -p diagnose <dump_data_diagnose.sql
