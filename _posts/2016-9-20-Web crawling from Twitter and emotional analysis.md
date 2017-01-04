---
layout: post
title: Building Naive Bayes Classifiers for Natural Language Processing & Emotional Analysis of real-time Twitter Streaming #Pokemon Go# 
category: analysis
---

People are getting crazy with Pokemon Go recently. Teenagers are wondering around along rivers and in parks to hunt. Grandma and Grandpa are driving out to catch rare ones. However, it is getting crazy. Some Pokemon fans are playing with their iPhones while driving on highway... So I wonder what the result will be like to do an emotional analysis on the topic of #Pokemon Go# on Twitter.

In this blog, I will first build a web crawler to capture real-time tweets. Then tweets are filtered based on location and keywords, so that only tweets that contains keyword "Pokemon" and sent in US are left. Then I trained two Naive Bayes classifiers using two different corpus from nltk, the movie_reviews and twitter_samples, respectively. However, surprising results are found that the classifier trained by movie_reviews are more reliable, even the data sets are from Twitter. I will talk about them in details.

### Web Crawling for Real-Time Twitter Streaming

Here I use a Python library called tweepy for accessing the Twitter API. First of all, one must have access_token, and consumer_key to access the authorization. Then a StreamListener class will be buit to monitor the tweeter streaming. Any newly posted tweets will trigger the on_status function in this listener. Within this on_status function, one can do filtering, natural language processing and classification. 
To prevent overflow, one can either set a time limit or item number limit on the streaming. 

Below is my Python code for the Tweeter API authorization part:

```python
import tweepy
import time
import os
import sys
start_time = time.time()
time_limit=60

consumer_key="Enter your key here"
consumer_secret="Enter your secret here"
access_token="Enter your token here"
access_token_secret="Enter your secret here"

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth)
```

And then the StreamListener

```python
tweets = []
save_file = open('13may.json', 'a')

class MyStreamListener(tweepy.StreamListener):
    def __init__(self, api):
        self.api = api or API()
        super(tweepy.StreamListener, self).__init__()
        self.save_file = tweets
        self.n = 0
        self.m = 200 
    def on_status(self, status):
        if ('pokemon' in status.text.lower()):
            print (status.text)
            self.n = self.n+1
        if self.n < self.m: return True
        else:
            print ('tweets = '+str(self.n))
            return False
    def on_error(self, status_code):
        if status_code == 420:
            #returning False in on_data disconnects the stream
            print("error")
            return False
        
myStreamListener = MyStreamListener(api)
myStream = tweepy.Stream(auth = api.auth, listener=myStreamListener)
key_filtered_stream=myStream.filter(locations=[-127.597019, 32.375215, -0.953617,48.152158])
```





