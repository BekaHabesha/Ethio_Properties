#!/usr/bin/python3
"""Starts a Flask web application.

The application listens on 0.0.0.0, port 5000.
Routes:
    /etpl: ETPL home page.
"""
import uuid
from flask import Flask, jsonify, render_template, url_for
from models import storage
import pymysql.cursors

# flask setup
app = Flask(__name__)
app.url_map.strict_slashes = False
port = 5000
host = '0.0.0.0'

# begin flask page rendering
@app.teardown_appcontext
def teardown_db(exception):
    """
    after each request, this method calls .close() (i.e. .remove()) on
    the current SQLAlchemy Session
    """
    storage.close()

# Connect to MySQL database
connection = pymysql.connect(host='localhost',
                             user='etpl_dev',
                             password='etpl_dev_pwd',
                             database='etpl_dev_db',
                             cursorclass=pymysql.cursors.DictCursor)

# Route to get the list of real estate properties
@app.route('/properties/')
def get_properties():
    try:
        with connection.cursor() as cursor:
            sql = "SELECT * FROM properties"
            cursor.execute(sql)
            properties = cursor.fetchall()
            return jsonify(properties)
    except Exception as e:
        return jsonify({'error': str(e)})

@app.route("/etpl_1/", strict_slashes=False)
def etpl_1(the_id=None):
    """
    handles request to custom template with states, cities & amentities
    """
    states = storage.all('State').values()
    amens = storage.all('Amenity').values()
    places = storage.all('Place').values()
    users = dict([user.id, "{} {}".format(user.first_name, user.last_name)]
                 for user in storage.all('User').values())
    cache_id = (str(uuid.uuid4()))
    return render_template('etpl.html',
                           states=states,
                           amens=amens,
                           places=places,
                           users=users,
                           cache_id=cache_id)

if __name__ == '__main__':
    """
    MAIN Flask App"""
    app.run(host=host, port=port)
