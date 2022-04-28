#!/bin/bash
date
working_dir=/Users/mlanciau
echo 'création du répertoire de log'
mkdir -p ${working_dir}/logs
echo 'changement de répertoire'
cd ${working_dir}/Documents/GitHub/DataPipelineDemo
echo 'exécution du script'
/usr/bin/python3 ${working_dir}/Documents/GitHub/DataPipelineDemo/grab_twitter_postgresql/main.py > ${working_dir}/logs/main.out 2>&1
CR=$?
echo 'Return code : '$CR
if [ ! $CR -eq 0 ];
then
  cp ${working_dir}/logs/main.out ${working_dir}/Desktop/grab_twitter_postgresql.out
fi
