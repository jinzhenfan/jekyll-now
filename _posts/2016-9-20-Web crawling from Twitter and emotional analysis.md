---
layout: post
title: Building Naive Bayes Classifiers for Natural Language Processing & Emotional Analysis of real-time Twitter Streaming #Pokemon Go# 
category: analysis
---

People are getting crazy with Pokemon Go recently. Teenagers are wondering around along rivers and in parks to hunt. Grandma and Grandpa are driving out to catch rare ones. However, it is getting crazy. Some Pokemon fans are playing with their iPhones while driving on highway... So I wonder what the result will be like to do an emotional analysis on the topic of #Pokemon Go# on Twitter.

In this blog, I will first build a web crawler to capture real-time tweets. Then tweets are filtered based on location and keywords, so that only tweets that contains keyword "#Pokemon" and sent in US are left. Then I trained two Naive Bayes classifiers using two different corpus from nltk, the movie_reviews and twitter_samples, respectively. However, surprising results are found that the classifier trained by movie_reviews are more reliable, even the data sets are from Twitter. I will talk about them in details.

### Web Crawling for Real-Time Twitter Streaming

Here I use an easy-to-use Python library called tweepy for accessing the Twitter API. First of all, one must have access_token, and consumer_key to access the authorization. Then a StreamListener class will be buit to monitor the tweeter streaming. Any newly posted tweets will trigger the on_status function in this listener. Within this on_status function, one can do filtering, natural language processing and classification. 
To prevent overflow, one can either set a time limit or item number limit on the streaming. 





