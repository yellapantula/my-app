node{
    stage('Scm checkout'){
        git credentialsId: 'git123', url: 'https://github.com/yellapantula/my-app'




    }
    stage('Mvn Package'){
        def mvnHome=tool name: 'maven-3', type: 'maven'
        def mvnCMD="${mvnHome}/bin/mvn"
        sh "${mvnCMD} clean package"


    }
}
