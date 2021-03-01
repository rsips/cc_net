aws2 ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 280268445914.dkr.ecr.eu-west-1.amazonaws.com
DOCKER_BUILDKIT=1 docker build  -t 280268445914.dkr.ecr.eu-west-1.amazonaws.com/cc_net -f ./Dockerfile . --ssh github_ssh_key=~/.ssh/id_rsa
docker push 280268445914.dkr.ecr.eu-west-1.amazonaws.com/cc_net
