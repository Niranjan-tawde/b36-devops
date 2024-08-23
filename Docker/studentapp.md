```Dockerfile
FROM ubuntu:20.04

USER root

RUN apt update -y

RUN apt install default-jdk -y

WORKDIR /opt/tomcat

ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.91/bin/apache-tomcat-9.0.91.tar.gz /opt/tomcat

RUN tar -xvzf apache-tomcat-9.0.91.tar.gz -C /opt/tomcat

ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/student.war /opt/tomcat/apache-tomcat-9.0.91/webapps/

ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/mysql-connector.jar /opt/tomcat/apache-tomcat-9.0.91/lib

COPY context.xml ./apache-tomcat-9.0.91/conf/context.xml

CMD ["apache-tomcat-9.0.91/bin/catalina.sh","run"]

```


```Dockerfile
FROM mariadb

LABEL database = "studentapp"

ENV MARIADB_ROOT_PASSWORD=1234

COPY student-rds.sql /docker-entrypoint-initdb.d/

CMD ["mariadbd"]
```

```
create database studentapp;
use studentapp;
CREATE TABLE if not exists students(student_id INT NOT NULL AUTO_INCREMENT,
        student_name VARCHAR(100) NOT NULL,
    student_addr VARCHAR(100) NOT NULL,
        student_age VARCHAR(3) NOT NULL,
        student_qual VARCHAR(20) NOT NULL,
        student_percent VARCHAR(10) NOT NULL,
        student_year_passed VARCHAR(10) NOT NULL,
        PRIMARY KEY (student_id)
);
```

#proxy_pass

 worker_processes 1;

events {
    worker_connections 1024;
}

http {
    sendfile on;

    upstream backend {
        server localhost:8080;
    }

    server {
        listen 80;

        location / {
            proxy_pass http://172.17.0.3:8080;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }
}
ProxyPass /student  http:/172.17.0.3:8080/student
ProxyPassReverse /student  http:/172.17.0.3:8080/student

```Dockerfile
FROM nginx

COPY nginx.conf /etc/nginx/nginx.conf
```
