from flask import Flask, render_template, Response
import requests
import picamera
import io
import time
import RPi.GPIO as GPIO
import threading

BUTTON = 17

GPIO.setmode(GPIO.BCM)
GPIO.setup(BUTTON, GPIO.IN)

ip_address = '192.168.29.28'
url = f'http://{ip_address}:5050/new_sign'
get_url = f'http://{ip_address}:5050/repi'
data = {"signName": "water"}

state = GPIO.input(BUTTON)

current_state = True

cap = 50
count = 0


def get_request(get_url):
    requests.get(get_url)


def post_request(url, data):
    try:
        response = requests.post(url, data=data)
        response.raise_for_status()  # Raise an exception for bad responses
        return response.text
    except requests.exceptions.RequestException as e:
        return f"Error: {e}"


def check_button():
	
    while True:
        global current_state
        state = GPIO.input(BUTTON)
        if current_state != state:
            print("Switching modes", state)
            
            current_state = state
            print(current_state)
        time.sleep(0.1)  # Adjust sleep duration as needed


def generate_frames():
    with picamera.PiCamera() as camera:
        camera.resolution = (640, 480)
        camera.framerate = 30
        # Give the camera some warm-up time
        time.sleep(2)
        stream = io.BytesIO()
        for _ in camera.capture_continuous(stream, format='jpeg', use_video_port=True):
            stream.seek(0)
            yield b'--frame\r\nContent-Type: image/jpeg\r\n\r\n' + stream.read() + b'\r\n'
            stream.seek(0)
            stream.truncate()
            time.sleep(0.1)  # Adjust sleep duration as needed


app = Flask(__name__)

# Start the button check thread
button_thread = threading.Thread(target=check_button)
button_thread.daemon = True  # Daemonize the thread so it will be terminated when the main program exits
button_thread.start()


@app.route('/stream')
def video_feed():
    return Response(generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)


def check_button():
    while True:
        global current_state
        state = GPIO.input(BUTTON)
        if not state and not current_state:
            print("start server")
            current_state=True
            get_request(get_url)
            time.sleep(3)
        elif not state and current_state:
            print("shut server")
            current_state=False
            get_request(get_url)
            time.sleep(3)