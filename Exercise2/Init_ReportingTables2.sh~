#!/bin/sh


impala-shell -q "create TABLE hive_practical_exercise_1.user_total(time_ran bigint, total_users bigint , users_added bigint);"

        if [ $? -eq 0 ]; then
	  echo Successfully created user_total table
          break
	else
	  echo failed to create user_total table
          exit 1
	fi
