import cv2
from cvzone.HandTrackingModule import HandDetector
import cvzone
import numpy as np
import math
import time
import os

stream_url = "http://192.168.29.193:5000/stream" # To stream using raspberry pi Only!

capture = cv2.VideoCapture(stream_url) # For capturing video using webcam
 
detector = HandDetector(maxHands=2) #Defining the number of hands valid 


def count_the_total_elements():
    with open('./Extra/word.txt', 'r') as file:
        count = file.readlines()
        
    total_count = len(count)
    return total_count


offset=18 # because the handImage is very cropped this adds some space 
imageSize = 48
counter = 0
pictures=500
count=0
class_name=count_the_total_elements()

while count<pictures:
    
    success,image=capture.read() # Uncomment this to use webcam as the source :)
    
    hands,image=detector.findHands(image,draw=True) # this creates the exoskeleton 
    
    
    imageResize=0
    handImage=0
    if hands:
        if len(hands)==2:
            hand1=hands[0]
            hand2=hands[1]
            x1,y1,w1,h1=hand1['bbox']
            x2,y2,w2,h2=hand2['bbox']
            handImage = image[min(y1,y2)-offset:max(y1,y2)+max(h1,h2)+offset,min(x1,x2)-offset:max(x1,x2)+max(w1,w2)+offset]
            handImage = cv2.cvtColor(handImage,cv2.COLOR_BGR2GRAY)
            imageResize = cv2.resize(handImage,(imageSize,imageSize))
            # print(x1,x2) #x1 is left
            
            
        elif(len(hands)==1):
            hand=hands[0]
            x,y,w,h=hand['bbox']
            handImage = image[y-offset:y+offset+h,x-offset:x+w+offset] # This takes a matrix as 
            handImage = cv2.cvtColor(handImage,cv2.COLOR_BGR2GRAY)
            imageResize = cv2.resize(handImage,(imageSize,imageSize))

        cv2.imshow("single",handImage)
        key= cv2.waitKey(1)
        if key == ord("s"): # To save the image the desired path press "s" key
            cv2.imwrite(f'data\{class_name}\{count}.jpg',imageResize)
            print(f'{class_name}-->{count}')
            count=count+1
    else:
        print("Hands out of frame")
        
        
    cv2.imshow("image",image)
    key= cv2.waitKey(1)
    
cv2.destroyAllWindows()