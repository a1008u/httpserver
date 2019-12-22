#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask, make_response
from flask import abort, jsonify, request
import datetime
import domain
import json

app = Flask(__name__)

@app.route('/')
def index():
    content = "Hello world'"

    # make_responseでレスポンスオブジェクトを生成する
    response = make_response(content)

    # Cookieの設定を行う
    max_age = 60 * 60 * 24 * 120 # 120 days
    expires = int(datetime.datetime.now().timestamp()) + max_age
    response.set_cookie('uid', value="**ユーザーIDなど**", max_age=max_age, expires=expires, path='/', secure=None, httponly=True, samesite="Lax")

    # レスポンスを返す
    return response

@app.route('/api/flask/hello')
def api():
    print(request.headers.get("Host"))
    print(request.environ)
    return jsonify({'ip': request.environ.get('HTTP_X_REAL_IP', request.remote_addr)}), 200

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=80)