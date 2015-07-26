# Dockerfile - Autosync for Google Drive
### 1. Create Google API Project
Google API console to visit.
https://code.google.com/apis/console

### 2. Click the Create Project button.
![google api console 0][0]

OR

### 3. click on the "API Project" -> "Create a project".
![google api console 1][1]

### 4. Write on Project name.
##### ex) google-drive
![google api console 2][2]

### 5. "API Project" -> "your project name".
![google api console 3][3]

### 6. "APIs & auth" -> "Credentials" -> "Create new Client ID"
![google api console 4][4]

### 7. Choose the "service account" in the application type.
![google api console 5][5]

### 8. Upload a JSON file to Dockerfile position.
![google api console 6][6]
![google api console 7][7]

### - Build
```sh
[root@ruo91 ~]# git clone https://github.com/ruo91/docker-google-drive.git /opt/docker-google-drive
[root@ruo91 ~]# cd /opt/docker-google-drive
[root@ruo91 ~]# docker build --rm -t google:drive .
```

### - Run
```sh
[root@ruo91 ~]# docker run -d --name="google-drive" -h "google-drive" \
-v /google-drive:/google-drive google:drive
```

### URL to Visit: https://goo.gl/Rj8OSu
##### click "accept".
![google api console 8][8]

### Copy this code, switch to your application and paste it into the next.
##### ex) 4/WtMATWYjR4GEy6KeiJ1eg-Ybq4DryBCgm6D5592-yNw
![google api console 9][9]

### - How to usage?
```sh
[root@ruo91 ~]# docker exec google-drive /bin/bash grive.sh -h
```
```sh
Usage: grive.sh [Options] [Authentication code]

- Please go to this URL and get an authentication code
- URL to visit: https://goo.gl/Rj8OSu

- Options
a, auth         : Authentication
s, sync         : Sync
```

### - Authentication
```sh
[root@ruo91 ~]# docker exec google-drive /bin/bash grive.sh auth 4/WtMATWYjR4GEy6KeiJ1eg-Ybq4DryBCgm6D5592-yNw
```
```sh
-----------------------
Please go to this URL and get an authentication code:

https://accounts.google.com/o/oauth2/auth?scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.profile+https%3A%2F%2Fdocs.google.com%2Ffeeds%2F+https%3A%2F%2Fdocs.googleusercontent.com%2F+https%3A%2F%2Fspreadsheets.google.com%2Ffeeds%2F&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code&client_id=22314510474.apps.googleusercontent.com

-----------------------
Please input the authentication code here:
Reading local directories
Synchronizing folders
Reading remote server file list
Synchronizing files
sync "./test.txt" created in remote. creating local
sync "./hello.txt" created in remote. creating local
Finished!
Already crontab exists!
```

### - Test
```sh
[root@ruo91 ~]# cat > /google-drive/2015-07-26.txt << EOF
> Hello, Yongbok Kim!
> EOF
```
```sh
[root@ruo91 ~]# ls -al /google-drive
total 24
drwxr-xr-x   2 root root   90 Jul 26 13:32 .
dr-xr-xr-x. 20 root root 4096 Jul 26 13:11 ..
-rw-r--r--   1 root root   20 Jul 26 13:32 2015-07-26.txt
-rw-------   1 root root   65 Jul 26 13:30 .grive
-rw-r--r--   1 root root   67 Jul 26 13:30 .grive_state
-rw-------   1 root root    7 Jul 26 12:42 hello.txt
-rw-------   1 root root    9 Jul 26 12:48 test.txt
```

### - Sync
```sh
[root@ruo91 ~]# docker exec google-drive /bin/bash grive.sh sync
```
```sh
Reading local directories
Synchronizing folders
Reading remote server file list
Detecting changes from last sync
Synchronizing files
sync "/google-drive/2015-07-26.txt" doesn't exist in server, uploading
Finished!
```
Thanks. :-)

[0]: http://cdn.yongbok.net/ruo91/img/docker/google-drive/google_api_console_0.png
[1]: http://cdn.yongbok.net/ruo91/img/docker/google-drive/google_api_console_1.png
[2]: http://cdn.yongbok.net/ruo91/img/docker/google-drive/google_api_console_2.png
[3]: http://cdn.yongbok.net/ruo91/img/docker/google-drive/google_api_console_3.png
[4]: http://cdn.yongbok.net/ruo91/img/docker/google-drive/google_api_console_4.png
[5]: http://cdn.yongbok.net/ruo91/img/docker/google-drive/google_api_console_5.png
[6]: http://cdn.yongbok.net/ruo91/img/docker/google-drive/google_api_console_6.png
[7]: http://cdn.yongbok.net/ruo91/img/docker/google-drive/google_api_console_7.png
[8]: http://cdn.yongbok.net/ruo91/img/docker/google-drive/google_api_console_8.png
[9]: http://cdn.yongbok.net/ruo91/img/docker/google-drive/google_api_console_9.png