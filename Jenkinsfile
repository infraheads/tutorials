podTemplate(yaml: '''
    apiVersion: v1
    kind: Pod
    metadata:
      name: kaniko
    spec:
      containers:
        - name: kaniko
          image: gcr.io/kaniko-project/executor:debug
          volumeMounts:
            - name: docker-config
              mountPath: /kaniko/.docker/
          command:
            - 'sleep'
          args:
            - '99999'
      restartPolicy: Never
      volumes:
        - name: docker-config
          secret:
            secretName: docker-config
    ''') {

        node(POD_LABEL) {
            stage("Get a Golang project") {
                git url: "https://github.com/fortranhub/demo.git", branch: "main"
                container("kaniko") {
                    stage("Build a Go project") {
                        sh '''
                            /kaniko/executor --context `pwd` --destination hakobmkoyan771/testgo
                        '''
                    }
                }
            }
        }
    }
