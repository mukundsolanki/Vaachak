import os
import time
import cv2
import mediapipe as mp
mp_drawing = mp.solutions.drawing_utils
mp_drawing_styles = mp.solutions.drawing_styles
mp_hands = mp.solutions.hands

DATA_DIR = './data'
number_of_classes = 10
dataset_size = 500

def captureStream():
    if not os.path.exists(DATA_DIR):
        os.makedirs(DATA_DIR)
    
    cap = cv2.VideoCapture("http://192.168.161.103:5000/stream")
    for j in range(5,number_of_classes):
        if not os.path.exists(os.path.join(DATA_DIR, str(j))):
            os.makedirs(os.path.join(DATA_DIR, str(j)))

        print('Collecting data for class {}'.format(j))

        done = 0
        while True:
            ret, frame = cap.read()
            cv2.putText(frame, 'Ready? Press "Q" ! :)', (100, 50), cv2.FONT_HERSHEY_SIMPLEX, 1.3, (0, 255, 0), 3,cv2.LINE_AA)
            cv2.imshow('frame', frame)
            if cv2.waitKey(1) == ord('q'):
                break
        cap.release()
        cv2.destroyAllWindows()
        time.sleep(5)
        
        cap = cv2.VideoCapture("http://192.168.161.103:5000/stream")
        time.sleep(5)
        counter = 0
        while counter < dataset_size:
            with mp_hands.Hands(
                model_complexity=0,
                min_detection_confidence=0.5,
                min_tracking_confidence=0.5) as hands:
              while cap.isOpened():
                success, image = cap.read()
                frame=image
                if not success:
                  print("Ignoring empty camera frame.")
                  # If loading a video, use 'break' instead of 'continue'.
                  continue
              
                # To improve performance, optionally mark the image as not writeable to
                # pass by reference.
                image.flags.writeable = False
                image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
                results = hands.process(image)

                # Draw the hand annotations on the image.
                image.flags.writeable = True
                image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)
                if results.multi_hand_landmarks:
                  for hand_landmarks in results.multi_hand_landmarks:
                    mp_drawing.draw_landmarks(
                        image,
                        hand_landmarks,
                        mp_hands.HAND_CONNECTIONS,
                        mp_drawing_styles.get_default_hand_landmarks_style(),
                        mp_drawing_styles.get_default_hand_connections_style())
                # Flip the image horizontally for a selfie-view display.
                final_frame=cv2.flip(image, 1)
                cv2.putText(final_frame, f'{counter}', (100, 50), cv2.FONT_HERSHEY_SIMPLEX, 1.3, (250, 250, 0), 3,cv2.LINE_AA)
                cv2.imshow('MediaPipe Hands', final_frame)
                cv2.waitKey(25)
                cv2.imwrite(os.path.join(DATA_DIR, str(j), '{}.jpg'.format(counter)), frame)
                print(counter)
                counter += 1
                if counter >= dataset_size : break

    cap.release()
    cv2.destroyAllWindows()

captureStream()


#V2
