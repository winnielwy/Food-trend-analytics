# -*- coding: utf-8 -*-
"""
Created on Tue Oct 28 20:11:01 2014

@author: mdotnasty
"""
import twitter
import json
import pandas as pd
from ConfigParser import SafeConfigParser
from datetime import datetime
import numpy as np
import requests
import semantria_sentiment as ss

start_time = datetime.now() #checking clock time    

def getCities():
    x = pd.read_csv('cities.csv')
    return x

def scrapeTweets(geocode,searchTerm):    
    '''
    parser = SafeConfigParser()
    parser.read("twitter.ini")
    consumer_key = parser.get('mo', 'CONSUMER_KEY')
    consumer_secret = parser.get('mo', 'CONSUMER_SECRET')
    oauth_access_token = parser.get('mo', 'OAUTH_TOKEN')
    oauth_access_secret = parser.get('mo', 'OAUTH_SECRET')
    
'''                               
    CONSUMER_KEY = 'pSynjA067DXoWHCiLj2vYOZih' 
    CONSUMER_SECRET ='XUL0KIf4tQb2s0g1T661KGq0j34PQH4ExzcL0mDVMGEgSsqBrq' 
    OAUTH_TOKEN = '120599266-EX081Phi13zAYWwsGE3F03aRn9a1NTeyJRx7zu5n' 
    OAUTH_TOKEN_SECRET = 'yqsGfmuEdxDXpeauYURnTqGkfWAcJweek2JYG1mqWu0Y6'
    auth = twitter.oauth.OAuth(OAUTH_TOKEN,
                               OAUTH_TOKEN_SECRET,
                               CONSUMER_KEY,
                               CONSUMER_SECRET)                           
    api = twitter.Twitter(auth=auth)
    searchCount = 255 
    # See https://dev.twitter.com/docs/api/1.1/get/search/tweets
    search_results = api.search.tweets(q=searchTerm, count=searchCount, 
                                       lang = 'en', geocode = geocode)
    statuses = search_results['statuses']

    # Iterate through 5 more batches of results by following the cursor
    for _ in range(5):
        try:
            next_results = search_results['search_metadata']['next_results'] 
        except KeyError, e: # No more results when next_results doesn't exist
           print "That's all folks ..."
        break
        # Create a dictionary from next_results, which has the following form:
        myKVs = [ kv.split('=') for kv in next_results[1:].split("&") ] 
        myStrippedKVs = [ [str(pp[0]), str(pp[1])] for pp in myKVs]
        kwargs = dict(myStrippedKVs)
        search_results = api.search.tweets(**kwargs)
        statuses += search_results['statuses']
        
    status_texts = [ status['text'] for status in statuses ]
    return status_texts

def sentiment_func(tweet):
    payload = {'txt':tweet}
    r = requests.post("http://sentiment.vivekn.com/api/text/",data=payload)
    result = json.loads(r.text)
    x =result['result']['sentiment']
    return x
       
cities = getCities()
searchTerms = open("food_trends.txt",'r').read().split(',')
list1 = []
list2 = []

for x in range(len(cities)):
#for x in range(1):    
    for term in searchTerms:
        geocode = str(cities['latitude'][x])+','+str(cities['longitude'][x])+',25mi'
        results=scrapeTweets(geocode,term)
        for tweet in results:
            s = sentiment_func(tweet)
            z = ss.sentiment(tweet,ss.init())
            list1.append( { 'city':cities['city'][x],'term':term,
                           'sentiment': s,'tweet':tweet })
            list2.append( { 'city':cities['city'][x],'term':term,
                           'sentiment': z,'tweet':tweet })                         
sentiment = pd.DataFrame(list1)
sentiment.to_csv("a.csv")

#Use semantra
sentiment2 = pd.DataFrame(list2)
sentiment2.to_csv("a2.csv")

sentimentTtl = sentiment.groupby(['city','term','sentiment']).count()
termTtl = sentiment.groupby(['city','term']).count()
sentimentTtl.to_csv("b.csv")        
termTtl.to_csv("c.csv")

sentimentTtl2 = sentiment2.groupby(['city','term','sentiment']).mean()
termTtl2 = sentiment2.groupby(['city','term']).mean()
sentimentTtl2.to_csv("b2.csv")        
termTtl2.to_csv("c2.csv")


end_time = datetime.now()
print('Duration: {}'.format(end_time-start_time))