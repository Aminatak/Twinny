#!/usr/bin/env python
# coding: utf-8

# ## TWINNY  : Réseau social pour sosies 

# - La reconnaissance faciale
# - L'extraction de différentes caractéristiques de l'image du visage (qui serviront à la comparaison)
# - Recherche des caractéristiques similaires
# - Retour d'un pourcentage d'exatitude de similarité 

# ## Importation des bibliotheques

# In[1]:


from matplotlib import pyplot as plt
from mtcnn.mtcnn import MTCNN
from matplotlib.patches import Rectangle
from numpy import asarray
from PIL import Image
from keras_vggface.utils import preprocess_input
from keras_vggface.vggface import VGGFace
from scipy.spatial.distance import cosine
import glob
import os
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import cv2
import os
import glob


# ### Definition du modele  Extraction du visage pour preparation du comparaison : à l'aide du 1er partie du Facenet

# In[2]:



def extract_face_from_image(image_path, required_size=(224, 224)):
  # load image and detect faces
    image = plt.imread(image_path)
    detector = MTCNN()
    faces = detector.detect_faces(image)

    face_images = []

    for face in faces:
        # extract the bounding box from the requested face
        x1, y1, width, height = face['box']
        x2, y2 = x1 + width, y1 + height

        # extract the face
        face_boundary = image[y1:y2, x1:x2]

        # resize pixels to the model size
        face_image = Image.fromarray(face_boundary)
        face_image = face_image.resize(required_size)
        face_array = asarray(face_image)
        face_images.append(face_array)

    return face_images


# In[3]:


def get_model_scores(faces):
    samples = asarray(faces, 'float32')

    # prepare the data for the model
    samples = preprocess_input(samples, version=2)

    # create a vggface model object
    model = VGGFace(model='resnet50',
      include_top=False,
      input_shape=(224, 224, 3),
      pooling='avg')

    # perform prediction
    return model.predict(samples)


# ### les 3 photos sur les quelles on a fait le Test de l'algorithme 
# 

# In[5]:

def get_gimine_pictur(path):
    img = Image.open(path)
    img.thumbnail((250, 250), Image.ANTIALIAS)
    imgplot = plt.imshow(img)


    # ### Afficher le contenu des dossier sources : players et actor

    # In[13]:



    # # MUST HAVE

    # In[17]:


    img_dir = r"C:\Users\FAIZ\Players"  
    data_path = os.path.join(img_dir,'*g')
    files = glob.glob(data_path)
    data = []
    tej = extract_face_from_image(path)
    model= get_model_scores(tej)
    plt.imshow(tej[0])
    print(" Your Inpute is : ")
    plt.show()
    results = []
    for f1 in files:
        a = str(f1)
        if (a.split('.')[1] == "jpg"):
            celib = extract_face_from_image(a)
            modelCelib= get_model_scores(celib)
            score = cosine(model[0],modelCelib[0])
            print(score)
            if (score <= 0.40):
                results.append((a,celib,score))

    print("\n ") 
    print("------------------------------------------------------------------------------------------------------------------------------ ") 
    print("Félicitations votre Sosie et le suivant !!!! ")  


    for q,r,score in results:
        print(r[0])
        plt.imshow(r[0])
        plt.show()


    print("\n ") 
    print("------------------------------------------------------------------------------------------------------------------------------ ") 
    print("Félicitations votre Sosie et le suivant !!!! ")
    results.sort(key=lambda  tup:tup[2] )
    results = results[:1]
    for q,r,score in results:
        plt.imshow(r[0])
        plt.title(q)
        plt.show()
        


# In[ ]:




