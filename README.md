# mongo-auth
Mongodb with authentication and many databases on Docker

[![Build Status](https://travis-ci.com/renatoruis/mongo-auth.svg?branch=master)](https://travis-ci.com/renatoruis/mongo-auth)


[See alson on GitHub](https://github.com/renatoruis/mongo-auth)

### Dockerfile
```
version: "3.4"
services:
  mongo:
    container_name: renatoruis/mongo-auth
    image: mongo-ruis
    restart: always
    environment:
      MONGODB_USER: "mydb"
      MONGODB_PASS: "mypassdb"
      CREATE_DATABASES: "db1;db2;db3"
    ports:
      - 27017:27017

```