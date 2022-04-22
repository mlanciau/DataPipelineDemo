#!/usr/bin/python3
import tweepy
import keyring
import psycopg2
import psycopg2.extras
from tweepy import Cursor

# gather credentials
tweepy_Bearer_Token = keyring.get_password("system", "tweepy_Bearer_Token")
dataGovOps_database_ip = '127.0.0.1'
dataGovOps_database_name = 'mlanciau'
dataGovOps_database_username = 'mlanciau'
dataGovOps_database_password = keyring.get_password("system", "dataGovOps_database_password")

# grab last id inserted into the DB
conn = psycopg2.connect(f"dbname={dataGovOps_database_name} user={dataGovOps_database_username} password={dataGovOps_database_password}")
cur = conn.cursor()
cur.execute("""
CREATE TABLE IF NOT EXISTS t_twitter_postgresql(
    c_id BIGINT PRIMARY KEY,
    c_text TEXT
)
;
""")
cur.execute("""
SELECT MAX(c_id) AS since_id
FROM t_twitter_postgresql
;
""")
data = cur.fetchone()
since_id = data[0]
print(f"since_id={since_id}")

# query twitter API and insert data into DB
query = """
INSERT INTO t_twitter_postgresql(c_id, c_text) VALUES(%s, %s)
;
"""
client = tweepy.Client(tweepy_Bearer_Token)
tweets = client.search_recent_tweets('postgresql', max_results=100, since_id=since_id)
values = []
if tweets.data is not None and len(tweets.data) > 0:
    for tweet in tweets.data:
        values.append((tweet.id, tweet.text, ))
    print(f"{len(values)} values")
    psycopg2.extras.execute_batch(cur, query, values)
else:
    print('No Data')

# close database connection
conn.commit()
cur.close()
conn.close()
