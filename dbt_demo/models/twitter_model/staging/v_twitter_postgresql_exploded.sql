WITH tmp AS (
  SELECT c_id, LOWER(regexp_split_to_table(c_text, '\s+')) AS c_word, c_created_at, c_lang
  FROM {{ ref('v_twitter_postgresql') }}
)

SELECT *
FROM tmp
WHERE LENGTH(c_word) > 3
