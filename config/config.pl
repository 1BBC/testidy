#!/usr/bin/perl -w
# onlytest configuretion file

$PROGRAM='onlytest';
$conf{base_dir}='/usr/onlytest/';
#DB configuration
$conf{dbhost}='localhost';
$conf{dbname}='abills';
$conf{dbuser}='abills';
$conf{dbpasswd}='sqlpassword';
$conf{dbtype}='mysql';
#For MySQL 5 and highter (cp1251, utf8)
$conf{dbcharset}='utf8';
$conf{WEB_TITLE}='TesTIDY';
$conf{domen_name}='http://192.168.0.102';
1;