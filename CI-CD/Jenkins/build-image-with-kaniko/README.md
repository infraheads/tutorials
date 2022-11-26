# Build a docker image with Jenkins on Kubernetes

* To build an image on Kubernetes there is a need of ```kaniko``` on kubernetes.
[Kaniko](https://github.com/GoogleContainerTools/kaniko)
* The current pipeline creates a pod in which will be 2 containers ```kaniko & agent for jenkins```.
* After creating the pod in stage ```Get the go app and build``` it will get the git repo for our example Dockerfile & with internal ```Build a Go project``` stage will build the image of cloned repo Dockerfile & push it to our dockerhub.
