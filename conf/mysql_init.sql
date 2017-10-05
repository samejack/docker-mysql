USE mysql;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('<MYSQL_ROOT_PASSWORD>');
DELETE FROM `user` WHERE `user` = 'root' AND `host` != 'localhost';

DELETE FROM `user` WHERE `user` = '<MYSQL_USER_NAME>';
INSERT INTO `user`(host, `user`, password) values('%', '<MYSQL_USER_NAME>', PASSWORD('<MYSQL_USER_PASSWORD>'));
UPDATE user SET password=PASSWORD('<MYSQL_USER_PASSWORD>') WHERE `user` = '<MYSQL_USER_NAME>';
DELETE FROM `db` WHERE `user` = '<MYSQL_USER_NAME>';
INSERT INTO `db` (`Host`, `Db`, `User`, `Select_priv`, `Insert_priv`, `Update_priv`, `Delete_priv`, `Create_priv`, `Drop_priv`, `Grant_priv`, `References_priv`, `Index_priv`, `Alter_priv`, `Create_tmp_table_priv`, `Lock_tables_priv`, `Create_view_priv`, `Show_view_priv`, `Create_routine_priv`, `Alter_routine_priv`, `Execute_priv`, `Event_priv`, `Trigger_priv`) VALUES ('%', '<MYSQL_USER_NAME>', '<MYSQL_USER_NAME>', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y');

FLUSH PRIVILEGES;

CREATE DATABASE <MYSQL_USER_NAME>;
