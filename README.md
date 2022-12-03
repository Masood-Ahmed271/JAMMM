# JAMMM - A COMP3278 Project
*Link To Demo Video:* <a href="https://youtu.be/5eBuB9qOC-Q"> https://youtu.be/5eBuB9qOC-Q </a>
## Contributors:
---
Author: Masood Ahmed <br>
Email: 'masood20@connect.hku.hk'<br>
UID: 3035812127

Author: Abdulwadood Ashraf Faazli <br>
Email: 'awaf2001@connect.hku.hk'<br>
UID: 3035832751

Author: Muhammad Mubeen <br>
Email: 'u3583178@connect.hku.hk'<br>
UID: 3035831783

Author: Li Hoi Kit  <br>
Email: 'u3574503@connect.hku.hk'<br>
UID: 3035745037

Author: Chan Kwok Cheung <br>
Email: 'u3582155@connect.hku.hk'<br>
UID: 3035821556

---

## Descriptions:
This is a course project where we are building a full stack web application using MySQL as database, React.js as Frontend, and Flask as Backend. In this project, a person can login via face recognition and after logging in, you can see a personal timetable, the classes scheduled in the coming one hour, and course details.

# Setup Details:

## Backend Setup:

For Backend, first enter the jamm-backend director and create a data directory:

```terminal/cmd
cd jamm-backend
mkdir data
```

### *Now Let's setup the face recognition system:*

### Setting Environment

Create virtual environment using Anaconda.
```
conda create -n face python=3.x
conda activate face
pip install -r requirements.txt
```

### MySQL Install

[Mac] https://dev.mysql.com/doc/mysql-osx-excerpt/5.7/en/osx-installation-pkg.html

[Ubuntu] https://dev.mysql.com/doc/mysql-linuxunix-excerpt/5.7/en/linux-installation.html

[Windows] https://dev.mysql.com/downloads/installer/

*******

#### To Collect Face Data

```
"""
user_name = "Jack"   # the name
NUM_IMGS = 400       # the number of saved images
"""
python face_capture.py
```
The camera will be activated and the captured images will be stored in `data/Jack` folder.      
**Note:** Only one person’s images can be captured at a time.

#### Now Train a Face Recognition Model
```
python train.py
```
`train.yml` and `labels.pickle` will be created at the current folder.


#### Now Let's Check If The Is Trained Correctly:
Go to either faces_gui.py or faces_.py and run the following the command:

```terminal/cmd
python faces.py
```
The camera will be activated and recognize your face using the pretrained model. 
If output is like `('Hello ', {name}, 'You did attendance today')` then the face is trained correctly.

#### Importing Database

Open mysql server and import the file `RealFinal.sql`.

```
# login the mysql command
mysql -u root -p

# create database.  'mysql>' indicates we are now in the mysql command line

# import from sql file. Replace the filename `RealFinal.sql` with the path to RealFinal.sql file on your local system
mysql> source RealFinal.sql
```

## Finally Running the Backend:
Go into jamm-backend  directory and run main.py
```terminal/cmd
python main.py
```

# Settting Up The Frontend:

Firstly, change the directory to `Jamm/jamm-frontend` then run following command:
```terminal/cmd
npm install
```

Then run the following command:
```terminal/cmd
npm start
```

# Important Note:
 While running, if some of the libraries are missing, do install them via `pip install {library-name}` or `npm install {library-name}`.
 
# Feedback

Pull requests are welcome. For feedback and suggestions, please reach out to Group 21.

# License
COMP3278 Group 21 2022 © The University of Hong Kong

Thank you for reading. Enjoy the app! Stay happy and stay safe :)
