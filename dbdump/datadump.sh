USER="appfactory"
PASS="root"
DATABASES=""
MYSQL_HOST="appfactory-prod.xxxxx.xxxx.amazonaws.com"

# Drop Existing DBs
for db in api_mgt_registry apimgt jpadb registry rss_mgt userstore apim_userstore appfactory_config as_dev_config as_prod_config as_test_config as_staging_config ss_config api_mgt_config af_bps_config sc_config s2_foundation billing redmine
do 
	mysql -h $MYSQL_HOST -u$USER -p$PASS -Bse "drop database if exists $db"
done

# Create DBs
for db in api_mgt_registry apimgt jpadb registry rss_mgt userstore apim_userstore appfactory_config as_dev_config as_prod_config as_test_config as_staging_config ss_config api_mgt_config af_bps_config sc_config s2_foundation billing redmine
do 
	mysql -h $MYSQL_HOST -u$USER -p$PASS -Bse "create database $db"
done


#mysql -h $MYSQL_HOST -u$USER -p$PASS -D mysql -Bse "INSERT INTO user  (User,Host,Password) VALUES('jpadb','%',PASSWORD('keeW3keiqu5aiKieL2eeT2Aisaigoo'));"


DBS_SAMPLE_DATABASE="testdb"
DBS_SAMPLE_DBUSER="testuser"
DBS_SAMPLE_DBUSERPASS="testuser123"
DBS_SAMPLE_DBTABLE="Persons"

#DBS Sample db creation
mysql -h $MYSQL_HOST -u$USER -p$PASS -Bse "drop database if exists $DBS_SAMPLE_DATABASE"
echo "drop database if exists $DBS_SAMPLE_DATABASE"

mysql -h $MYSQL_HOST -u$USER -p$PASS -Bse "create database $DBS_SAMPLE_DATABASE"
echo "create DBS_SAMPLE_DATABASE $DBS_SAMPLE_DATABASE"

mysql -h $MYSQL_HOST -u$USER -p$PASS -Bse "create user $DBS_SAMPLE_DBUSER identified by '$DBS_SAMPLE_DBUSERPASS'"
echo "create user $DBS_SAMPLE_DBUSER identified by '$DBS_SAMPLE_DBUSERPASS'"

mysql -h $MYSQL_HOST -u$USER -p$PASS -Bse "grant SELECT on $DBS_SAMPLE_DATABASE.* to $DBS_SAMPLE_DBUSER identified by '$DBS_SAMPLE_DBUSERPASS'"
echo "grant select on $DBS_SAMPLE_DATABASE.* to $DBS_SAMPLE_DBUSER identified by '$DBS_SAMPLE_DBUSERPASS'"

mysql -h $MYSQL_HOST -u$USER -p$PASS -Bse "create table $DBS_SAMPLE_DATABASE.$DBS_SAMPLE_DBTABLE(id VARCHAR(100), data VARCHAR(100))"
echo "create table $DBS_SAMPLE_DATABASE.$DBS_SAMPLE_DBTABLE(id VARCHAR(100), data VARCHAR(100))"

mysql -h $MYSQL_HOST -u$USER -p$PASS -Bse "insert into $DBS_SAMPLE_DATABASE.$DBS_SAMPLE_DBTABLE values(1,'sample data1')"
echo "insert into $DBS_SAMPLE_DATABASE.$DBS_SAMPLE_DBTABLE values(1,'sample data1')"

mysql -h $MYSQL_HOST -u$USER -p$PASS -Bse "insert into $DBS_SAMPLE_DATABASE.$DBS_SAMPLE_DBTABLE values(2,'sample data 2')"
echo "insert into $DBS_SAMPLE_DATABASE.$DBS_SAMPLE_DBTABLE values(1,'sample data 2')"

mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on registry.* to registry identified by 'xxxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on sc_config.* to registry identified by 'xxxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on appfactory_config.* to registry identified by 'xxxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on as_dev_config.* to registry identified by 'xxxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on as_prod_config.* to registry identified by 'xxxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on as_test_config.* to registry identified by 'xxxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on as_staging_config.* to registry identified by 'xxxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on api_mgt_config.* to registry identified by 'xxxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on af_bps_config.* to registry identified by 'xxxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on userstore.* to userstore identified by 'xxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on apim_userstore.* to userstore identified by 'xxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on jpadb.* to jpadb identified by 'xxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on redmine.* to admin identified by 'xxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on redmine.* to redmine identified by 'xxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on s2_foundation.* to s2user identified by 'xxxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on apimgt.* to apimgt identified by 'xxxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on api_mgt_registry.* to apimgt identified by 'xxxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on rss_mgt.* to rss_mgt identified by 'xxxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on ss_config.* to registry identified by 'xxxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on billing.* to s2user identified by 'xxxxx'"
mysql -h $MYSQL_HOST -u$USER -p$PASS  -Bse "grant all on testdb.* to testuser identified by 'xxxxx'"



for db in appfactory_config as_dev_config as_prod_config as_test_config as_staging_config ss_config api_mgt_config af_bps_config api_mgt_registry  registry userstore apim_userstore sc_config
do
	mysql -h $MYSQL_HOST -u$USER -p$PASS $db < dbscripts/registry.sql
done

for db in apimgt jpadb 
do
	mysql -h $MYSQL_HOST -u$USER -p$PASS $db < dbscripts/$db.sql
done

mysql -h $MYSQL_HOST -u$USER -p$PASS rss_mgt < dbscripts/wso2_rss_mysql.sql
mysql -h $MYSQL_HOST -u$USER -p$PASS billing < dbscripts/metering_mysql.sql
mysql -h $MYSQL_HOST -u$USER -p$PASS billing < dbscripts/billing.sql

mysql -h $MYSQL_HOST -u$USER -p$PASS s2_foundation < dbscripts/s2foundation_schema.sql

mysql -h $MYSQL_HOST -u$USER -p$PASS redmine <  redmine.sql.withsettings
exit 

