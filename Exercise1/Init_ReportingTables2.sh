#!/bin/sh


hive -e "create TABLE hive_practical_exercise_1.user_total(time_ran int, total_users int , users_added int);"

        if [ $? -eq 0 ]; then
	  echo Successfully created user_total table
          
	else
	  echo failed to create user_total table
          exit 1
	fi
