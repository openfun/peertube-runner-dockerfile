## Dockerfile for peertube-runner

This repo contains a Dockerfile to run a [peertube-runner](https://docs.joinpeertube.org/maintain/tools#peertube-runner) instance.
The generated image should be run as an Un-privileged user.

## Build

To build the image, run `make build`. The `build` task generates an image with the tag `peertube-runner:latest`.

## Configuration

The `peertube-runner` instance can be configured using environment variable. The following environment variables
can be used : 

- `PEERTUBE_RUNNER_JOBS_CONCURRENCY`: Amount of transcoding jobs to execute in parallel. Default: `2`
- `PEERTUBE_RUNNER_FFMPEF_THREADS`: Amount of threads used by ffmpeg for 1 local transcoding job. Default: `2`
- `PEERTUBE_RUNNER_FFMPEG_NICE`: ffmpeg niceness value, between -20 and 20. Default: `0`
- `PEERTUBE_RUNNER_REGISTERED_INSTANCE_URL`: A registered instance url. Default: `none`
- `PEERTUBE_RUNNER_REGISTERED_INSTANCE_RUNNER_TOKEN`: A registered instance runner token. Default: `none`
- `PEERTUBE_RUNNER_REGISTERED_INSTANCE_RUNNER_NAME`: A registered instance runner name. Default: `none`

## Run

```bash
$ docker run --rm -it \
    -e PEERTUBE_RUNNER_REGISTERED_INSTANCE_URL=http://localhost:9000 \
    -e PEERTUBE_RUNNER_REGISTERED_INSTANCE_RUNNER_TOKEN=foo-token \
    -e PEERTUBE_RUNNER_REGISTERED_INSTANCE_RUNNER_NAME=instance-name \
    peertube-runner:latest
```

The default command run in the container is `peertube-runner server` which run a peertube-runner server.

