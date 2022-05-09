WITH tmp AS (
  SELECT c_id, c_text, c_lang, CASE WHEN STARTS_WITH(c_text, 'RT') THEN true ELSE false END AS c_retweet,
  TO_TIMESTAMP(c_created_at, 'YYYY-MM-DD HH24:MI:SS') AS c_created_at, c_loaded_at, c_author_id
  FROM {{ source('twitter_model', 't_twitter_postgresql') }}
)

SELECT *
FROM tmp
{% if target.name == 'dev' -%}
WHERE c_created_at > CURRENT_TIMESTAMP - 3 * Interval '1 month'
{% endif %}
