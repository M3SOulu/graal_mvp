FROM ubuntu:20.04

# Install npm
RUN apt-get -y update
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_20.x -o /tmp/nodesource_setup.sh && bash /tmp/nodesource_setup.sh && apt-get install -y nodejs

# Move package to container
COPY frontend /
COPY backend /

# Move data to container
# TODO Use ARG to specify sources
RUN cp /graal-prophet-utils/output_trainticket/entities.json /frontend/src/data/contextMap.json && cp /graal-prophet-utils/output_trainticket/communicationGraph.json /frontend/src/data/communicationGraph.json

# Build the visualizer
WORKDIR /frontend

RUN npm install

ENTRYPOINT npm start
EXPOSE 3000
