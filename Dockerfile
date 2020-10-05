FROM digitalocean/doctl:1.46.0 as doctl
FROM alpine/helm:3.3.4 as helm
FROM bitnami/kubectl:1.19.2 as kubectl
FROM nosinovacao/fluxctl:19.12.0 as fluxctl
FROM argoproj/argocd:v1.7.7 as argocd

FROM alpine:latest

WORKDIR /usr/local/bin

COPY --from=doctl /app/doctl .
COPY --from=helm /usr/bin/helm .
COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl .
COPY --from=fluxctl /usr/local/bin/fluxctl .
COPY --from=argocd /usr/local/bin/argocd .

RUN chown root:root ./*

CMD ls -l /usr/local/bin
