# -*- coding: utf-8 -*-
"""
Created on Sun Nov 30 22:44:34 2014

@author: mdotnasty
"""

import requests
import json
import pandas as pd
from datetime import datetime

start_time = datetime.now() #checking clock time    
def sentiment(tweet):
    url = 'https://api.idolondemand.com/1/api/sync/analyzesentiment/v1'
    payload = {'apikey':'d08df64c-c66d-4a4e-aeba-80043d0e4223','text':tweet}
    r = requests.post(url,data=payload)
    result = json.loads(r.text)
    return result['aggregate']['score']

tweets = pd.read_csv('tweets.csv')
tweets['sentiment'] = 55.45

for i in range(len(tweets)):
    text = tweets['tweet'][i]
    tweets['sentiment'][i] = sentiment(text)

tweets.to_csv("tweets_with_sentiment.csv")               
x = tweets.groupby(['city','term'])[['sentiment']].mean()
y = tweets.groupby(['city','term']).count()['tweet']

sentiment = pd.concat([x,y],axis=1,join='inner')
sentiment.to_csv("sentiment.csv")        


end_time = datetime.now()
print('Duration: {}'.format(end_time-start_time)) 
       