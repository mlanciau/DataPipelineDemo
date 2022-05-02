#!/bin/bash
date
user_dir=/Users/mlanciau
virtualenv_dir=${user_dir}/Documents/GitHub/DataPipelineDemo/dbt_demo
echo 'création des répertoires'
mkdir ${user_dir}/logs
echo 'changement de répertoire'
cd ${virtualenv_dir}
/opt/homebrew/bin/dbt seed
CR=$?
echo 'Return code : '$CR
if [ ! $CR -eq 0 ];
then
  cp ${user_dir}/logs/dbt_seed.out ${user_dir}/Desktop/dbt_seed.out
  exit $CR
fi
/opt/homebrew/bin/dbt source freshness
CR=$?
echo 'Return code : '$CR
if [ ! $CR -eq 0 ];
then
  cp ${user_dir}/logs/dbt_source_freshness.out ${user_dir}/Desktop/dbt_source_freshness.out
  exit $CR
fi
/opt/homebrew/bin/dbt seed
CR=$?
echo 'Return code : '$CR
if [ ! $CR -eq 0 ];
then
  cp ${user_dir}/logs/dbt_seed.out ${user_dir}/Desktop/dbt_seed.out
  exit $CR
fi
/opt/homebrew/bin/dbt test
CR=$?
echo 'Return code : '$CR
if [ ! $CR -eq 0 ];
then
  cp ${user_dir}/logs/dbt_test.out ${user_dir}/Desktop/dbt_test.out
  exit $CR
fi
/opt/homebrew/bin/dbt run
CR=$?
echo 'Return code : '$CR
if [ ! $CR -eq 0 ];
then
  cp ${user_dir}/logs/dbt_run.out ${user_dir}/Desktop/dbt_run.out
  exit $CR
fi
/opt/homebrew/bin/dbt docs generate
CR=$?
echo 'Return code : '$CR
if [ ! $CR -eq 0 ];
then
  cp ${user_dir}/logs/dbt_docs_generate.out ${user_dir}/Desktop/dbt_docs_generate.out
  exit $CR
fi
