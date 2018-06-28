#!/bin/sh

hive -e "CREATE DATABASE IF NOT EXISTS temp_practical_exercise_1;"

hive -e "DROP TABLE if exists temp_practical_exercise_1.updates"
hive -e "DROP TABLE if exists temp_practical_exercise_1.inserts"
hive -e "DROP TABLE if exists temp_practical_exercise_1.deletes"
hive -e "DROP TABLE if exists temp_practical_exercise_1.activitytype"
hive -e "DROP TABLE if exists temp_practical_exercise_1.isactive"
hive -e "DROP TABLE if exists temp_practical_exercise_1.uploadcount"


hive -e "CREATE  TABLE hive_practical_exercise_1.updates as select user_id, count(*) cnt FROM hive_practical_exercise_1.activitylog WHERE type='UPDATE' group by user_id ;"

if [ $? -eq 0 ]; then
	  echo Successfully created update table
          break
	else
	  echo failed to create update table
          exit 1
	fi

hive -e "CREATE  TABLE hive_practical_exercise_1.inserts as SELECT user_id, count(*) InsertCount FROM hive_practical_exercise_1.activitylog WHERE type='INSERT' group by user_id ;"
if [ $? -eq 0 ]; then
	  echo Successfully created inserts table
          break
	else
	  echo failed to create inserts table
          exit 1
	fi

hive -e "CREATE  TABLE hive_practical_exercise_1.deletes as SELECT user_id, count(*) deletecount FROM hive_practical_exercise_1.activitylog WHERE type='DELETE' group by user_id ;"
if [ $? -eq 0 ]; then
	  echo Successfully created deletes table
          break
	else
	  echo failed to create deletes table
          exit 1
	fi

hive -e "CREATE TABLE hive_practical_exercise_1.activitytype as select activitylog.user_id, ts,type from (SELECT user_id,MAX(timestamp) ts from hive_practical_exercise_1.activitylog group by user_id) z left outer join hive_practical_exercise_1.activitylog on z.ts= activitylog.timestamp AND z.user_id=activitylog.user_id;"
if [ $? -eq 0 ]; then
	  echo Successfully created activitytype table
          break
	else
	  echo failed to create activitytype table
          exit 1
	fi

#hive -e "CREATE  TABLE hive_practical_exercise_1.activitytype as SELECT user_id, type from  hive_practical_exercise_1.temp1;"


#hive -e "CREATE TEMPORARY TABLE hive_practical_exercise_1.activitytype as SELECT e.user_id, e.type from  (SELECT activitylog.user_id, type from (SELECT user_id,MAX(timestamp) ts from hive_practical_exercise_1.activitylog group by user_id) z left outer join hive_practical_exercise_1.activitylog on z.ts= activitylog.timestamp)e   ;"

hive -e "CREATE  TABLE hive_practical_exercise_1.isactive as SELECT user_id, if  ( unix_timestamp() - ts < 172800, 1,0) s from hive_practical_exercise_1.activitytype ;"

if [ $? -eq 0 ]; then
	  echo Successfully created isactive table
          break
	else
	  echo failed to create isactive table
          exit 1
	fi


#hive -e "CREATE TEMPORARY TABLE hive_practical_exercise_1.isactive as  select ftab.user_id, ftab.s from    (SELECT a.user_id, if  ( unix_timestamp() - ts < 172800, 1,0) s from (select activitylog.user_id, ts from (SELECT user_id,MAX(timestamp) ts from hive_practical_exercise_1.activitylog group by user_id) z left outer join hive_practical_exercise_1.activitylog on z.ts= activitylog.timestamp) a) ftab  ;"


hive -e "CREATE  TABLE hive_practical_exercise_1.uploadcount as  select user_id, count(*)upc from hive_practical_exercise_1.csv group by user_id  ;"

if [ $? -eq 0 ]; then
	  echo Successfully created uploadcount table
          break
	else
	  echo failed to create uploadcount table
          exit 1
	fi

hive -e "CREATE TABLE hive_practical_exercise_1.user_report as select u.id ,COALESCE(upd.cnt,0) updatecount, COALESCE(ins.InsertCount,0) insertcount , COALESCE(del.deletecount,0) deletecount ,act.type, isa.s as isactive, COALESCE(upl.upc,0) uploadcount
from hive_practical_exercise_1.user u
left outer join hive_practical_exercise_1.updates upd on u.id=upd.user_id
left outer join hive_practical_exercise_1.inserts ins on u.id=ins.user_id
left outer join hive_practical_exercise_1.deletes del on  u.id=del.user_id
left outer join hive_practical_exercise_1.activitytype act on u.id=act.user_id
left outer join hive_practical_exercise_1.isactive isa on u.id=isa.user_id
left outer join hive_practical_exercise_1.uploadcount upl on u.id=upl.user_id;"

if [ $? -eq 0 ]; then
	  echo Successfully created user_report table
          break
	else
	  echo failed to create user_report table
          exit 1
	fi


hive -e "DROP TABLE hive_practical_exercise_1.updates"
hive -e "DROP TABLE hive_practical_exercise_1.inserts"
hive -e "DROP TABLE hive_practical_exercise_1.deletes"
hive -e "DROP TABLE hive_practical_exercise_1.activitytype"
hive -e "DROP TABLE hive_practical_exercise_1.isactive"
hive -e "DROP TABLE hive_practical_exercise_1.uploadcount"
#hive -e "DROP TABLE hive_practical_exercise_1.temp1"

hive -e "select * from hive_practical_exercise_1.user_report;"





