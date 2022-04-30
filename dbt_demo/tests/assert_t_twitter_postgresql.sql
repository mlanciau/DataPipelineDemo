WITH tmp AS (
  SELECT COUNT(*) AS c_nbr
  FROM {{ source('twitter_model', 't_twitter_postgresql') }}
)

SELECT *
FROM tmp
WHERE c_nbr <= 0
