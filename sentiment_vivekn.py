# -*- coding: utf-8 -*-
"""
Created on Tue Oct 28 20:11:01 2014

@author: mdotnasty
"""

import json
import pandas as pd
from datetime import datetime
import requests

start_time = datetime.now() #checking clock time    

def sentiment_func(tweet):
    payload = {'txt':tweet}
    r = requests.post("http://sentiment.vivekn.com/api/text/",data=payload)
    result = json.loads(r.text)
    x =result['result']['sentiment']
    return x
       
tweets = pd.read_csv('tweets.csv')
tweets['sentiment'] = 0

for x in range(len(tweets)):
    tweets['sentiment'][x] = sentiment_func(tweets['tweet'][x])
               

sentiment = tweets.groupby(['city','term','sentiment']).count()
termTtl = tweets.groupby(['city','term']).count()['tweet']

sentiment.to_csv("sentiment_vivekn.csv")        
termTtl.to_csv("termTtl_vivekn.csv",header = True)

end_time = datetime.now()
print('Duration: {}'.format(end_time-start_time))