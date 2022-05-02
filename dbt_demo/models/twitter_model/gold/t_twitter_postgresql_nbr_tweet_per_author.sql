SELECT c_author_id, COUNT(*) AS c_nbr
FROM {{ ref('v_twitter_postgresql') }}
GROUP BY c_author_id
