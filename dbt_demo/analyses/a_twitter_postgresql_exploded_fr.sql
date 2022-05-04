SELECT c_word, c_category, COUNT(*) AS c_nbr
FROM {{ ref('t_twitter_postgresql_exploded') }}
WHERE c_lang = 'fr'
GROUP BY c_word, c_category
ORDER BY c_nbr DESC
LIMIT 25
