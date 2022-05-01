SELECT c_id, c_text, TO_TIMESTAMP(c_created_at, 'YYYY-MM-DD HH24:MI:SS+TZH') AS c_created_at, c_lang, c_loaded_at
FROM {{ source('twitter_model', 't_twitter_postgresql') }}
