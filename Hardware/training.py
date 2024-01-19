import pickle

from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import numpy as np


data_dict = pickle.load(open('Model\data.pickle', 'rb'))
# data_dict2 = pickle.load(open('./Model\data2.pickle', 'rb'))


data = np.asarray(data_dict['data'])
print(data_dict)
labels = np.asarray(data_dict['labels'])
# print(labels)
x_train, x_test, y_train, y_test = train_test_split(data, labels, test_size=0.25,shuffle=True, stratify=labels)
model = RandomForestClassifier()
model.fit(x_train, y_train)
y_predict = model.predict(x_test)
score = accuracy_score(y_predict, y_test)
print('{}% of samples were classified correctly Part 1 !'.format(score * 100))
f = open('./Model\model.p', 'wb')
pickle.dump({'model': model}, f)