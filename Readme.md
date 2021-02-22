Regit docker images
===================

Docker images used for setting up development and speeding up CI builds.

-----
##### !!! Please note:
`dev` image is an extended `ci` image, when rebuilding you need to rebuild `ci` first.

-----

#### 1. Login to docker
Run `docker login` and enter your username and password to login

#### 2. To rebuild CI config
```
docker pull php:7.4-fpm-alpine
docker build -t regitcars/php-fpm:ci ci
docker push regitcars/php-fpm:ci
```

#### 3. To rebuild dev config
```
docker build -t regitcars/php-fpm:dev dev
docker push regitcars/php-fpm:dev
```

#### 4. To rebuild CI-next config
```
docker pull php:8.0-fpm-alpine
docker build -t regitcars/php-fpm:ci-next ci-next
docker push regitcars/php-fpm:ci-next
```

#### 5. To rebuild dev-next config
```
docker build -t regitcars/php-fpm:dev-next dev-next
docker push regitcars/php-fpm:dev-next
```
