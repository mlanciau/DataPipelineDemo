{{ config(
  materialized='view'
) }}

with v_twitter_postgresql as (
    SELECT c_id, c_text, c_created_at
    FROM {{ source('twitter_model', 't_twitter_postgresql') }}
)

SELECT *
FROM v_twitter_postgresql
