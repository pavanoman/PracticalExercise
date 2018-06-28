#!/bin/sh

echo "Creating Hive Database....."

impala-shell -q "CREATE DATABASE IF NOT EXISTS hive_practical_exercise_1;"

echo "Creating scoop job....."



	sqoop job --meta-connect jdbc:hsqldb:hsql://localhost:16000/sqoop --create hive_practical_exercise_1.activitylog -- import --connect jdbc:mysql://localhost/practical_exercise_1 --username root --password-file /user/cloudera/root_pwd.txt --table activitylog -m 4 --hive-import --hive-database hive_practical_exercise_1 --hive-table activitylog --incremental append --check-column id --last-value 0


	

	if [ $? -eq 0 ]; then
	  echo successfully created sqoop job - activitylog table...
          break
        else 
          echo Process failed 
          exit 1
	
	fi



       


