#!/usr/bin/python3
#coding: utf_8

# API
## https://developer.chatwork.com/reference/get-me
# API Token
## https://www.chatwork.com/service/packages/chatwork/subpackages/api/token.php

# Howto Execute
## env X-CHATWORK-TOKEN='<API TokenID>' python3 chatwork_me.py

import requests
import os
import json

url = "https://api.chatwork.com/v2/me"
token = os.environ.get("X-CHATWORK-TOKEN","")
headers = {"accept": "application/json", "X-Chatworktoken": token}

response = requests.get(url, headers=headers)
##print(response.text)

json_data = json.loads(response.text)
print(json.dumps(json_data, indent=2, ensure_ascii=False))
