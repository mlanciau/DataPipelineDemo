SELECT CAST(c_created_at AS DATE) AS c_date, COUNT(*) AS c_nbr
FROM {{ ref('v_twitter_postgresql') }}
GROUP BY CAST(c_created_at AS DATE)
