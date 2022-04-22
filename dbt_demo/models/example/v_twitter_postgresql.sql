{{ config(materialized='view') }}

with v_twitter_postgresql as (
    SELECT c_id, c_text
    FROM t_twitter_postgresql
)

SELECT *
FROM v_twitter_postgresql
