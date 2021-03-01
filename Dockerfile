FROM python:3.9-slim-buster
RUN apt-get update; 
RUN apt-get update && apt-get install -y libboost-all-dev python-dev git cmake g++ gdb python-dbg  curl wget libboost-python-dev libboost-dev build-essential zlib1g-dev libboost-system-dev libboost-program-options-dev
RUN apt-get install zip unzip

RUN mkdir /app
WORKDIR /app
COPY . /app
RUN make install
ENV AWS_PCLUSTER_CONFIG_FILE=/app/myt_cluster_config
RUN pip install aws-parallelcluster
#CMD ['./run_cc_net.sh']
CMD ["bash", "./run_cc_net.sh"]