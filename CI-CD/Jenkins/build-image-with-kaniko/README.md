# Build a docker image with Jenkins on Kubernetes

> To build an image on Kubernetes there is a need of **_[Kaniko](https://github.com/GoogleContainerTools/kaniko)_** on kubernetes.
## Current pipeline creates a pod in which will be 2 containers **_kaniko_** & **_jnlp_** agent for jenkins.

## Steps
1. Base64 Encode your docker username and password.
> **_Example_**: echo -n username:password | base64 | tr -d "\n"
2. Base64 encode docker configuration with already **_encoded_** username password
> **_Example_**: {"auths":{"https://index.docker.io/v1/":{"auth":"here should be your encrypted username password from **step 1**"}}}
3. Put your encoded docker configuration from the **step 2** in the 3rd line of **_[docker-config](https://github.com/infraheads/tutorials/blob/main/CI-CD/Jenkins/build-image-with-kaniko/docker-config-secret.yaml)_** secret file.
4. Apply the **_[docker-config](https://github.com/infraheads/tutorials/blob/main/CI-CD/Jenkins/build-image-with-kaniko/docker-config-secret.yaml)_** secret file on your kubernetes cluster.
> **_Example_**: kubectl create -f docker-config-secret.yaml
5. Modify the line 24th of **_[Jenkinsfil](https://github.com/infraheads/tutorials/blob/main/CI-CD/Jenkins/build-image-with-kaniko/Jenkinsfile)_**, replace the **repo/app** with your own.

* After creating the pod in stage ```Get the go app and build``` it will get the git repo for our example Dockerfile & with internal ```Build a Go project``` stage will build the image of cloned repo Dockerfile & push it to our dockerhub.
