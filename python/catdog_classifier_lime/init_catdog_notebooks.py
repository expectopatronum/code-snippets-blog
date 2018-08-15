import cv2                 # working with, mainly resizing, images
import numpy as np         # dealing with arrays
import os                  # dealing with directories
from random import shuffle # mixing up or currently ordered data that might lead our network astray in training.
from tqdm import tqdm      # a nice pretty percentage bar for tasks. Thanks to viewer Daniel Bühler for this suggestion

from catdog_config import IMG_SIZE

def label_img(img):
    word_label = img.split('.')[-3]
    # conversion to one-hot array [cat,dog]
    #                            [much cat, 
    if word_label == 'cat': return [1,0]
    #                             [no cat, v
    elif word_label == 'dog': return [0,1]
    
# TODO: encode image size in file name
def create_train_data(train_dir = None, load_from_disk=False):
    if load_from_disk:
        training_data = np.load('train_data.npy')
    else:
        training_data = []
        for img in tqdm(os.listdir(train_dir)):
            label = label_img(img)
            path = os.path.join(train_dir,img)
            img = cv2.imread(path,cv2.IMREAD_COLOR)
            img = cv2.resize(img, (IMG_SIZE,IMG_SIZE))
            training_data.append([np.array(img),np.array(label)])
        shuffle(training_data)
        np.save('train_data.npy', training_data)
    return training_data

def process_test_data(test_dir=None, load_from_disk=False):
    if load_from_disk:
        testing_data = np.load('test_data.npy')
    else:
        testing_data = []
        for img in tqdm(os.listdir(test_dir)):
            path = os.path.join(test_dir,img)
            img_num = img.split('.')[0]
            img = cv2.imread(path,cv2.IMREAD_COLOR)
            img = cv2.resize(img, (IMG_SIZE,IMG_SIZE))
            testing_data.append([np.array(img), img_num])

        shuffle(testing_data)
        np.save('test_data.npy', testing_data)
    return testing_data

