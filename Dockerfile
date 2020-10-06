FROM digitalocean/doctl:latest as doctl
FROM alpine/helm:latest as helm
FROM bitnami/kubectl:latest as kubectl
FROM nosinovacao/fluxctl:latest as fluxctl
FROM argoproj/argocd:latest as argocd

FROM alpine:latest as tools

WORKDIR /usr/local/bin

COPY --from=doctl /app/doctl .
COPY --from=helm /usr/bin/helm .
COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl .
COPY --from=fluxctl /usr/local/bin/fluxctl .
COPY --from=argocd /usr/local/bin/argocd .

RUN chown root:root ./*
CMD ls -l /usr/local/bin

FROM python:alpine as versions

COPY --from=tools /usr/local/bin/ /usr/local/bin/

WORKDIR /opt
COPY src/get-versions.py ./

RUN python get-versions.py

FROM node:12.3 as readme-generation

WORKDIR /opt

COPY package.json current-versions.json src/readme.mustache src/generate-versions.js ./
COPY --from=versions /opt/versions.json ./

RUN yarn install
