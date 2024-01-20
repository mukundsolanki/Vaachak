import pickle
import numpy as np
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import matplotlib.pyplot as plt


data_dict = pickle.load(open('Model\data.pickle', 'rb'))

data = np.asarray(data_dict['data'])
labels = np.asarray(data_dict['labels'])
x_train, x_test, y_train, y_test = train_test_split(data, labels, test_size=0.25, shuffle=True, stratify=labels)

#Store accuracy here!
accuracy_values = []

# Train and store the accuracy of the model
for _ in range(60):  #More iteration will increase the accuracy of the model
    model = RandomForestClassifier()
    model.fit(x_train, y_train)
    y_predict = model.predict(x_test)
    score = accuracy_score(y_predict, y_test)
    accuracy_values.append(score)

    print(f'Iteration {_ + 1}: {score * 100:.2f}% of samples were classified correctly')

plt.plot(range(1, len(accuracy_values) + 1), accuracy_values, marker='o')
plt.title('Accuracy Across Iterations')
plt.xlabel('Iteration')
plt.ylabel('Accuracy')
plt.show()


with open(model_path, 'wb') as f:
    pickle.dump({'model': model}, f)
