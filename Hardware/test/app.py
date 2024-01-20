import cv2
import threading
import time
from flask import Flask, request
from tkinter import Tk, Label, Button

app = Flask(__name__)

open_camera = False

def open_camera_for_5_seconds():
    global open_camera
    open_camera = True

    # Open the camera
    cap = cv2.VideoCapture(0)
    cv2.namedWindow("Camera", cv2.WINDOW_NORMAL)

    timeout = time.time() + 5

    while time.time() < timeout:
        ret, frame = cap.read()
        cv2.imshow("Camera", frame)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()

    open_camera = False

@app.route('/start-training', methods=['POST'])
def start_training():
     print('Start')

@app.route('/receive-text', methods=['POST'])
def receive_text():
    try:
        received_text = request.form['text']
        print('Received text:', received_text)
        print('Text received sucessfully')

        threading.Thread(target=open_camera_for_5_seconds).start()
        print('Camera started sucessfully')

        return 'Text received successfully!', 200
    except KeyError:
        return 'Text parameter missing in the request', 400

if __name__ == '__main__':
    app.run(host='192.168.34.67', port=8000)