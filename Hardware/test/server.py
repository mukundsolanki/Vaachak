import cv2
import threading
import time
import os
from flask import Flask, request

app = Flask(__name__)

open_camera = False

def open_camera_for_5_seconds(video_name):
    global open_camera
    open_camera = True

    # Open the camera
    cap = cv2.VideoCapture(0)

    fourcc = cv2.VideoWriter_fourcc(*'XVID')
    out = cv2.VideoWriter(video_name, fourcc, 20.0, (640, 480))

    timeout = time.time() + 5

    while time.time() < timeout:
        ret, frame = cap.read()
        cv2.imshow("Camera", frame)

        out.write(frame)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    out.release()
    cv2.destroyAllWindows()

    open_camera = False

@app.route('/receive-text', methods=['POST'])
def receive_text():
    try:
        received_text = request.form['text']
        print('Received text:', received_text)
        print('Text received successfully')

        video_name = f"video/{received_text}.avi"
        threading.Thread(target=open_camera_for_5_seconds, args=(video_name,)).start()
        print('Camera started successfully')

        return 'Text received successfully!', 200
    except KeyError:
        return 'Text parameter missing in the request', 400
    
app.route('/start-training', methods=['POST'])
def start_training():
    try:
        # Perform actions related to starting the training here
        # You can print the received data, process it, etc.
        print('Received POST request to start training.')

        # Respond with a success message
        return 'Training started successfully!', 200
    except Exception as e:
        # Respond with an error message and status code 500 if an exception occurs
        print(f'Error: {e}')
        return 'Internal Server Error', 500

if __name__ == '__main__':
    # Create the 'video' directory if it doesn't exist
    if not os.path.exists('video'):
        os.makedirs('video')

    app.run(host='192.168.197.67', port=5050)