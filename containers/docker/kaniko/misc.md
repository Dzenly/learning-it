https://docs.gitlab.com/ee/ci/docker/using_kaniko.html




https://medium.com/01001101/enhance-your-docker-image-build-pipeline-with-kaniko-567afb6cf97c

Userspace.

gcr.io/kaniko-project/executor
or
gcr.io/kaniko-project/executor:debug

*Does not support Windows*

Note about Local Directory: this option refers to a directory within the kaniko container. If you wish to use this option, you will need to mount in your build context into the container as a directory.

https://github.com/GoogleContainerTools/kaniko#comparison-with-other-tools


https://medium.com/01001101/enhance-your-docker-image-build-pipeline-with-kaniko-567afb6cf97c

Kaniko does not depend on Docker. So can be run in docker containers without
Docker installed.


$CI_REGISTRY contains the name of the projects image Registry
$CI_JOB_TOKEN contains a one-time token which to authenticate against the project image Registry
$CI_PROJECT_DIR contains the path of your project
$CI_REGISTRY_IMAGE contains the image name
$CI_BUILD_REF will be used as image tag

https://gitlab.com/nmeisenzahl/soccnx14-demo/blob/master/.gitlab-ci.yml

https://gitlab.com/gitlab-org/gitlab/-/issues/23141

https://github.com/GoogleContainerTools/kaniko/issues/875

https://gitlab.com/nmeisenzahl/soccnx14-demo/blob/master/.gitlab-ci.yml



