# PracticalExercise

Exercise 1 (Hive):

There are 6 shell scripts in this exercise that we will be using for running hive commands.

Run Instructions:
Run three initialization scripts if this is the first time of running the program otherwise we can directly run main scripts. We have run MysqlToHive.sh and csvToHive.sh first to import all the data from mysql and csv's. Then we can run ReportingTables scripts to get the final result.

Initialization Scripts Details:

1. Init_MysqlToHive.sh: This script creates Hive database. It also creates scoop job for activitylog table.
2. Init_csvToHive.sh: This script creates 2 directories in hadoop for storing csv files. CSVDump directory stores processed csv files and LatestCSV stores csv which we are currently processing. It also creates table 'csv' to store data from csv's.
3. Init_ReportingTables2.sh: It creates 'user_total' table.

Main Scripts Details:

4. MysqlToHive.sh: 
Using scoop import, this script imports user table in hive. It executes sqoop job for activitylog table.
5. csvToHive.sh: 
Here I am storing 'user_dump*.csv' files from my local LatestCSV folder to hadoop LatestCSV folder. Then i am moving files on my local machine from LatestCSV folder to CSVDump folder. In this way we will have all the files from clients in separate directory. Then i am copying files on hadoop from LatestCSV to CSVDump to make sure we have same data in hadoop and on local machine. Using 'Load Data Inpath' command i am storing data from LatestCSV on hadoop to 'csv' table.
6. ReportingTables1.sh:This script creates user_report table.
7. ReportingTables2.sh:This script creates user_total table.

Exercise 2 (Impala and Airflow):

This exercise is very similar to exercise 1. In code, we are using Impala instead of Hive and airflow running main scripts. 

Run Instructions:
We have to run initialization scripts from the terminal. Then we have to trigger the airflow dag 'airflow_practical_exercise'.
This dag executes main shell scripts after triggering it.  MysqlToHive.sh and csvToHive.sh scripts will be executed first then 
ReportingTables scripts.
