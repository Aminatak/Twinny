from flask import Flask, render_template, jsonify
import Facenet_detection

app = Flask(name)

@app.route('/')
def meteo():
    return Facenet_detection.get_gimine_pictur(r"MESSI1load.jpg")


if name == "main":
    app.run(debug=True)