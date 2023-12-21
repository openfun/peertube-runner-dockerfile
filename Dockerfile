FROM node:20-slim

# Install FFMPEG
RUN apt update && \
    apt install -y ffmpeg && \
    rm -rf /var/lib/apt/lists/*

COPY files/usr/local/bin/entrypoint /usr/local/bin/entrypoint

# Install peertube-runner
RUN npm install -g @peertube/peertube-runner@${PEERTUBE_RUNNER_VERSION:-"0.0.9"}

# Un-privileged user running the application
ARG DOCKER_USER
USER ${DOCKER_USER}

ENTRYPOINT [ "entrypoint" ]
CMD [ "peertube-runner", "server" ]