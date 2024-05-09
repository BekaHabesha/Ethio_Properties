#!/usr/bin/python3
"""Starts a Flask web application.

The application listens on 0.0.0.0, port 5000.
Routes:
    /etpl: ETPL home page.
"""
from flask import Flask, jsonify
import pymysql.cursors

app = Flask(__name__)

# Connect to MySQL database
connection = pymysql.connect(host='localhost',
                             user='etpl_dev',
                             password='etpl_dev_pwd',
                             database='etpl_dev_db',
                             cursorclass=pymysql.cursors.DictCursor)

# Route to get the list of real estate properties
@app.route('/properties')
def get_properties():
    try:
        with connection.cursor() as cursor:
            sql = "SELECT * FROM properties"
            cursor.execute(sql)
            properties = cursor.fetchall()
            return jsonify(properties)
    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(debug=True)
