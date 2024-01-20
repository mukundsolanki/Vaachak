import cv2
import pickle
import time
import mediapipe as mp
import numpy as np

model_dict=pickle.load(open('./Model\model.p','rb'))
model=model_dict['model']
dic=['B','C']

print("Starting detect using pi 1")
time.sleep(3)
# if not send_get_request("http://192.168.29.193:5000/stream"): return
cap = cv2.VideoCapture(0)
mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils
mp_drawing_styles = mp.solutions.drawing_styles
hands = mp_hands.Hands(static_image_mode=True, min_detection_confidence=0.3)
while True:
    # print("Starting detect using pi 2")
    data_aux = []
    x_ = []
    y_ = []
    ret, frame = cap.read()
    if not ret:
        cap.release()
        cv2.destroyAllWindows()
        break
    H, W, _ = frame.shape
    frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    results = hands.process(frame_rgb)
    if results.multi_hand_landmarks:
        for hand_landmarks in results.multi_hand_landmarks:
            mp_drawing.draw_landmarks(
                frame,  # image to draw
                hand_landmarks,  # model output
                mp_hands.HAND_CONNECTIONS,  # hand connections
                mp_drawing_styles.get_default_hand_landmarks_style(),
                mp_drawing_styles.get_default_hand_connections_style())
        for hand_landmarks in results.multi_hand_landmarks:
            for i in range(len(hand_landmarks.landmark)):
                x = hand_landmarks.landmark[i].x
                y = hand_landmarks.landmark[i].y
                x_.append(x)
                y_.append(y)
            for i in range(len(hand_landmarks.landmark)):
                x = hand_landmarks.landmark[i].x
                y = hand_landmarks.landmark[i].y
                data_aux.append(x - min(x_))
                data_aux.append(y - min(y_))
        x1 = int(min(x_) * W) - 10
        y1 = int(min(y_) * H) - 10
        x2 = int(max(x_) * W) - 10
        y2 = int(max(y_) * H) - 10
        predicted_character = ""
        if len(data_aux) == 42:
            prediction = model.predict([np.asarray(data_aux)])
            predicted_character = int(prediction[0])
            # predicted_character = dic[int(prediction[0])]
            confidence = max(model.predict_proba([np.asarray(data_aux)])[0])
            print(confidence," --> ",predicted_character)