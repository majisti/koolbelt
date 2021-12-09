# Koolbelt

A Kubernetes CLI toolbet. Includes doctl, helm, argocd, fluxcd, kubectl...

It is a simple multi stage docker build with the latest versions of the tools.

Currently packaged tools and their versions:

    - **dotcl**: 1.68.0
    - **helm**: 3.7.2
    - **kubectl**: 1.22.4
    - **argocd**: 2.2.0
    - **fluxcd**: 1.20.2

We probably mostly want to use that as a local image on our machine, plugging
this to a CI will probably demand lots of network bandwidth as this image will
probably grow in size, but in the end, it is up to you!

Will probably add more. At [Majisti](https://majisti.com) we do not like to have global dependencies on our machines!

# Usage

Running a container from the image will list all the available tools:

```
docker run --rm -it majisti/koolbelt
```

You can then use the installed tools:

```
docker run --rm -it majisti/koolbelt kubectl
```

Do not forget to add your env vars or volume mount your config files!

Say you are using Digital Ocean with Kubernetes, making this an alias can be ideal:

```
alias k='docker run --rm -it -e DIGITALOCEAN_ACCESS_TOKEN=$DIGITALOCEAN_ACCESS_TOKEN -v $HOME/.kube:/root/.kube majisti/koolbelt kubectl'
```

# Contributing

Some more essential tools should be added to this image? Submit a PR and make sure to run `make generate-versions` to
regenerate the `README.md` and `current-versions.json` files.
