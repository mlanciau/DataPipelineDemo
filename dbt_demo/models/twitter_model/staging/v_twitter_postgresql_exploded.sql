WITH tmp AS (
  SELECT c_id, LOWER(regexp_split_to_table(c_text, '\s+')) AS c_word, c_created_at, c_lang, c_retweet, c_author_id
  FROM {{ ref('v_twitter_postgresql') }}
)

SELECT tmp.*, CASE WHEN STARTS_WITH(tmp.c_word, '@') THEN 'author'
              WHEN STARTS_WITH(tmp.c_word, '#') THEN 'hashtag'
              WHEN STARTS_WITH(tmp.c_word, 'https://') THEN 'links'
              ELSE t.c_label
              END c_category
FROM tmp
LEFT OUTER JOIN {{ ref('t_word_semantic_lite') }} t
ON tmp.c_word = t.c_word
WHERE LENGTH(tmp.c_word) > 3
  AND tmp.c_word NOT IN (SELECT c_word FROM {{ ref('t_word_filter_lite') }})
