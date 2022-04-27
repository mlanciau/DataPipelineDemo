#!/usr/bin/python3
import sys
import tweepy
import keyring
import argparse
import psycopg2
import psycopg2.extras

# parse argument
parser = argparse.ArgumentParser()
parser.add_argument('-t', '--tweepy_Bearer_Token',
                    help='Tweepy Bearer Token', required=True)
args = parser.parse_args()

# gather credentials
tweepy_Bearer_Token = args.tweepy_Bearer_Token
dataGovOps_database_ip = '127.0.0.1'
dataGovOps_database_name = 'mlanciau'
dataGovOps_database_username = 'mlanciau'
dataGovOps_database_password = keyring.get_password(
    "system", "dataGovOps_database_password")

# grab last id inserted into the DB
conn = psycopg2.connect(
    f"dbname={dataGovOps_database_name} user={dataGovOps_database_username} password={dataGovOps_database_password}")
cur = conn.cursor()
cur.execute("""
CREATE TABLE IF NOT EXISTS t_twitter_postgresql(
    c_id BIGINT PRIMARY KEY,
    c_text TEXT,
    c_created_at TEXT
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

# return_code
return_code = 0

# query twitter API and insert data into DB
query = """
INSERT INTO t_twitter_postgresql(c_id, c_text, c_created_at) VALUES(%s, %s, %s)
;
"""
if tweepy_Bearer_Token is None:
    print('No bearer token')
    return_code = 1
else:
    # print(tweepy_Bearer_Token)
    client = tweepy.Client(tweepy_Bearer_Token)
    tweets = client.search_recent_tweets(
        'postgresql', max_results=100, since_id=since_id, tweet_fields=['created_at', 'lang', 'author_id'])
    values = []
    if tweets.data is not None and len(tweets.data) > 0:
        for tweet in tweets.data:
            values.append((tweet.id, tweet.text, tweet.created_at, ))
        print(f"{len(values)} values")
        psycopg2.extras.execute_batch(cur, query, values)
    else:
        print('No Data')

# close database connection
conn.commit()
cur.close()
conn.close()

sys.exit(return_code)
