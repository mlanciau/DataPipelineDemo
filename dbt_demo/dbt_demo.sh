#!/bin/bash
date
user_dir=/Users/mlanciau
virtualenv_dir=${user_dir}/Documents/GitHub/DataPipelineDemo/dbt_demo
echo 'création des répertoires'
mkdir ${user_dir}/logs
echo 'changement de répertoire'
cd ${virtualenv_dir}
echo 'dbt deps'
/opt/homebrew/bin/dbt deps > ${user_dir}/logs/dbt_deps.out 2>&1
CR=$?
echo 'Return code : '$CR
if [ ! $CR -eq 0 ];
then
  cp ${user_dir}/logs/dbt_deps.out ${user_dir}/Desktop/dbt_deps.out
  exit $CR
fi
echo 'dbt source freshness'
/opt/homebrew/bin/dbt source freshness > ${user_dir}/logs/dbt_source_freshness.out 2>&1
CR=$?
echo 'Return code : '$CR
if [ ! $CR -eq 0 ];
then
  cp ${user_dir}/logs/dbt_source_freshness.out ${user_dir}/Desktop/dbt_source_freshness.out
  exit $CR
fi
echo 'dbt seed'
/opt/homebrew/bin/dbt seed > ${user_dir}/logs/dbt_seed.out 2>&1
CR=$?
echo 'Return code : '$CR
if [ ! $CR -eq 0 ];
then
  cp ${user_dir}/logs/dbt_seed.out ${user_dir}/Desktop/dbt_seed.out
  exit $CR
fi
echo 'dbt test'
/opt/homebrew/bin/dbt test > ${user_dir}/logs/dbt_test.out 2>&1
CR=$?
echo 'Return code : '$CR
if [ ! $CR -eq 0 ];
then
  cp ${user_dir}/logs/dbt_test.out ${user_dir}/Desktop/dbt_test.out
  exit $CR
fi
echo 'dbt run'
/opt/homebrew/bin/dbt run > ${user_dir}/logs/dbt_run.out 2>&1
CR=$?
echo 'Return code : '$CR
if [ ! $CR -eq 0 ];
then
  cp ${user_dir}/logs/dbt_run.out ${user_dir}/Desktop/dbt_run.out
  exit $CR
fi
echo 'dbt docs generate'
/opt/homebrew/bin/dbt docs generate > ${user_dir}/logs/dbt_docs_generate.out 2>&1
CR=$?
echo 'Return code : '$CR
if [ ! $CR -eq 0 ];
then
  cp ${user_dir}/logs/dbt_docs_generate.out ${user_dir}/Desktop/dbt_docs_generate.out
  exit $CR
fi
