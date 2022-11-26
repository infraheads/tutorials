# Build a docker image with Jenkins on Kubernetes

> To build an image on Kubernetes there is a need of **_[Kaniko](https://github.com/GoogleContainerTools/kaniko)_** on kubernetes.
### Current pipeline creates a pod in which will be 2 containers **_kaniko_** & **_jnlp_** agent for jenkins.

## Steps
1. Base64 Encode your docker username and password.
> **_Example_**: echo -n username:password | base64 | tr -d "\n"
2. Base64 encode docker configuration with already **_encoded_** username password <br />
2.1 Create a simple file. 
> **_Example_** touch secret <br />
2.2 Put this configuration {"auths":{"https://index.docker.io/v1/":{"auth":"here should be your encrypted username password from **step 1**"}}} in the file you create with **step 2.1**<br />
> **_Note_**: interactive encoding the docker configuration from terminal will create a wrong encoded object as it will delete the quotes ```"``` from the configuration and after that will create wrong encoded object. That is why we need to put it(docker config) in a file and after that encode the file with the configuration in it. <br />
2.3 Base64 encode the file. <br />
> **_Example_**: base64 ./secret
3. Put your encoded docker configuration from the **step 2** in the 3rd line of **_[docker-config](https://github.com/infraheads/tutorials/blob/main/CI-CD/Jenkins/build-image-with-kaniko/docker-config-secret.yaml)_** secret file.
4. Apply the **_[docker-config](https://github.com/infraheads/tutorials/blob/main/CI-CD/Jenkins/build-image-with-kaniko/docker-config-secret.yaml)_** secret file on your kubernetes cluster.
> **_Example_**: kubectl create -f docker-config-secret.yaml
5. Modify the line 24th of **_[Jenkinsfil](https://github.com/infraheads/tutorials/blob/main/CI-CD/Jenkins/build-image-with-kaniko/Jenkinsfile)_**, replace the **repo/app** with your own.
