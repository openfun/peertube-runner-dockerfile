FROM node:20-slim AS runner

# Install FFMPEG
RUN apt update && \
    apt install -y ffmpeg && \
    rm -rf /var/lib/apt/lists/*

COPY files/usr/local/bin/entrypoint /usr/local/bin/entrypoint

# Install peertube-runner
RUN npm install -g @peertube/peertube-runner@${PEERTUBE_RUNNER_VERSION:-"0.0.22"}

# Un-privileged user running the application
ARG DOCKER_USER
USER ${DOCKER_USER}

ENTRYPOINT [ "entrypoint" ]
CMD [ "peertube-runner", "server" ]

FROM runner AS whisper_ctranslate2

USER root:root

RUN apt-get update && \
    apt install -y python3-pip && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install whisper-ctranslate2==0.4.6 --break-system-packages

# Un-privileged user running the application
ARG DOCKER_USER
USER ${DOCKER_USER}

ENV PEERTUBE_RUNNER_TRANSCRIPTION_ENGINE="whisper-ctranslate2"

ENV PEERTUBE_RUNNER_TRANSCRIPTION_MODEL="tiny"

ENV PEERTUBE_RUNNER_TRANSCRIPTION_ENGINE_PATH="/usr/local/bin/whisper-ctranslate2"
