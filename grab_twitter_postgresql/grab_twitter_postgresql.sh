#!/bin/bash
date
user_dir=/Users/mlanciau
virtualenv_dir=${user_dir}/cron/grab_twitter_postgresql
echo 'création des répertoires'
mkdir ${user_dir}/logs
echo 'changement de répertoire'
cd ${virtualenv_dir}
echo 'activation de l'\''environnement python'
source venv/bin/activate
echo 'installation des dépendances'
python3 -m pip install -r ${user_dir}/Documents/GitHub/DataPipelineDemo/grab_twitter_postgresql/requirements.txt > ${user_dir}/logs/pip.out 2>&1
CR=$?
echo 'Return code : '$CR
if [ ! $CR -eq 0 ];
then
  cp ${user_dir}/logs/pip.out ${user_dir}/Desktop/grab_twitter_postgresql.out
fi
echo 'exécution du script'
tweepy_Bearer_Token=$(head -n 1 ${user_dir}/.tweepy_Bearer_Token.txt)
python3 ${user_dir}/Documents/GitHub/DataPipelineDemo/grab_twitter_postgresql/main.py -t=${tweepy_Bearer_Token} > ${user_dir}/logs/main.out 2>&1
CR=$?
echo 'Return code : '$CR
if [ ! $CR -eq 0 ];
then
  cp ${user_dir}/logs/main.out ${user_dir}/Desktop/grab_twitter_postgresql.out
fi
