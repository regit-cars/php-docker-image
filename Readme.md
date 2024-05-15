# Regit docker images

Docker images used for setting up development and speeding up CI builds in Regit projects.

## Images organisation

The **php-docker-image** repository has been updated to improve the organisation of the different PHP image versions needed in the local development environment and the CI pipeline.

The new folder distribution in the php-docker-image repository is as follows:

```terminal
\8.1
....\ci
....\dev
\8.2
....\ci
....\dev
\X.Y
....\ci
....\dev
```

Where:

- **8.1, 8.2, X.Y:** The different PHP versions available.
- **ci:** Contains the Dockerfile for the CI image used in the CI pipeline.
- **dev:** Contains the Dockerfile for the development image used in the local development environment.

## Images naming convention

The Docker image tagging has also been updated; now, the tagging will follow the following nomenclature:

```terminal
<vendor>/php:<version>-<variant>-<environment>

e.g.:

regitcars/php:8.2-fpm-ci
regitcars/php:8.1-fpm-dev
regitcars/php:X.Y-fpm-dev
```

Where:

- **vendor:** Will always be **regitcars**.
- **version:** One of the available versions. For example: **8.1**, **8.2**, **X.Y**, etc...
- **variant:** Will always be **fpm**.
- **environment:** Can be either **ci** or **dev**.

> **Note:** With this nomenclature, we'll achieve a more intuitive tagging system that follows the same tagging convention as the official PHP images on Docker.

## Images build

The images are built using the Dockerfiles located in the `ci` and `dev` folders. The `ci` folder contains the Dockerfile for the CI image, and the `dev` folder contains the Dockerfile for the development image.

> **Note:** The `dev` image is an extended version of the `ci` image, so when rebuilding the images, you need to rebuild the `ci` image first.

### 1. Login to Docker

Run the following command to log in to Docker:

```terminal
docker login
```

Enter your username and password to log in.

> **Note:** You need to have a Docker Hub account to log in and the necessary permissions to push images to the Docker Hub.

### 2. Rebuild the CI image

To rebuild the CI image, follow these steps:

```terminal
cd 8.2/ci 
docker build -t regitcars/php:8.2-fpm-ci .
```

## Push images to Docker Hub

We need to push the images to Docker Hub to make them available for use in the CI pipeline and local development environment.

To push the images to Docker Hub, follow these steps:

### 3. Push the CI image

```terminal
docker push regitcars/php:<version>-fpm-<environment>
```

Where `version` will be the PHP version of the image you want to push, and `environment` will be either `ci` or `dev`.

For example, to push the `8.2-fpm-ci` image, run the following command:

```terminal
docker push regitcars/php:8.2-fpm-ci
```
> **Note:** Before pushing an image, make sure you have logged in to Docker and the image has been built successfully.

## Dev image build

### 4. Rebuild and push the dev image

```terminal
cd 8.2/dev 
docker build -t regitcars/php:8.2-fpm-dev .
docker push regitcars/php:8.2-fpm-dev
```

For the rest of versions and environments, follow the same procedure.
