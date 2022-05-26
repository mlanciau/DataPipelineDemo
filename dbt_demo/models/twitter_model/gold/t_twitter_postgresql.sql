{{
  config(
    materialized = 'incremental',
    unique_key = 'c_id'
  )
}}

SELECT *
FROM {{ ref('v_twitter_postgresql') }}
{% if  is_incremental() %}
WHERE c_id > (SELECT MAX(c_id) FROM {{ this }})
{% endif %}
 
