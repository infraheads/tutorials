resource "helm_release" "jenkins_chart" {
    name = "jenkins"
    chart = "jenkins"
    repository = "https://charts.jenkins.io/"
}


resource "kubernetes_secret" "kaniko_secret" {
  metadata {
      name = "docker-config"
  }
  
  data = {
      "config.json" = "${file("~/.docker/config.json")}"
  }
}