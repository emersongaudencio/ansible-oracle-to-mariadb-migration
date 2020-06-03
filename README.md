# ansible-oracle-to-mariadb-migration
Ansible routine to deploy SQLines tool to assist migration from Oracle to MariaDB on CentOS / Red Hat Linux distros

### SQLines will be installed and used on a intermediate machine to be a bridge between Oracle to MariaDB.

## Proposed Scenario

* Intermediate machine for SQLines
* Oracle source database
* MariaDB target database

e.g:

```
  Source Database                  *Migration host*                 Target Database
+------------------+             +------------------+             +------------------+
|                  |             |      SQLines     |             |                  |
| Oracle Database  | <=========> |   intermediate   | <=========> | MariaDB Database |
|                  |             |      host        |             |                  |
+------------------+             +------------------+             +------------------+
```

## Links and references:
* [SQLines](http://www.sqlines.com/sqldata)

* [SymmetricDS](https://www.symmetricds.org/)

* [Amazon DMS](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Introduction.htm)

* [Amazon Schema convertion tool](https://aws.amazon.com/dms/schema-conversion-tool/)

* [Oracle Golden Gate](https://docs.oracle.com/goldengate/1212/ggwinux/GWUAD/wu_about_gg.htm#GWUAD110)

* [Oracle to MariaDB Migration - Oracle Compatibility Mode](http://www.sqlines.com/oracle-to-mariadb-compatibility)

* [Oracle to MariaDB Migration](http://www.sqlines.com/oracle-to-mariadb)

* [Oracle to MariaDB Migration - Deep dive](https://severalnines.com/database-blog/migration-oracle-database-mariadb-deep-dive)

### Install SQLines on Linux (CentOS/Redhat/AmazonLinux)
```
sh install_ansible_sqlines.sh
```

### 1rst - How to setup SQLines on Linux
```
[root@srv-sqlines ~]# sudo su - mysqlines
[mysqlines@srv-sqlines ~]$ ls
```

### output from above commands
```
[mysqlines@srv-sqlines ~]$ ls
instantclient_12_2                            instantclient-sqlplus-linux.x64-12.2.0.1.0.zip  oradiag_mysql                  sqlinesdata31777_x86_64_linux.tar.gz
instantclient-basic-linux.x64-12.2.0.1.0.zip  instantclient-tools-linux.x64-12.2.0.1.0.zip    sqlinesdata31777_x86_64_linux  tnsnames.ora
```

### 2nd - Setup oracle datasource using tnsnames.ora file
```
[mysqlines@srv-sqlines ~]$ vi tnsnames.ora
```

```
XE =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 172.16.122.250)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = XE)
    )
  )
```

### 3rd - Test connection between source and target databases

E.g for Oracle:
```
sqlplus CEP/teste123@XE
```

E.g for MariaDB/MySQL:
```
mysql --user=app_user --password=test123 --host=172.16.122.128 --port=3306
```

PS: keep in ming that you have to be able to connect on the source and target databases from the intermediate machine that we are using to migrate our data from oracle to mariadb

### 4th - How to use sqldata from SQLines

```
./sqldata -sd=oracle,CEP/teste123@XE -td=mariadb,app_user/test123@172.16.122.128,CEP -t=*.* -ss=6 -out=/home/mysqlines -log=migration_cep.log -mysql_set_foreign_key_checks=0
```

PS: keep an eye on the sqldata.cfg file to setup the defaults related to the source and target databases
