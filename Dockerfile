FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y curl wget build-essential cmake mesa-utils libxrandr-dev libxinerama-dev libxcursor-dev xvfb && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /
RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.6/julia-1.6.0-rc1-linux-x86_64.tar.gz
RUN tar xf julia-1.6.0-rc1-linux-x86_64.tar.gz
RUN rm julia-1.6.0-rc1-linux-x86_64.tar.gz
RUN ln -s /julia-1.6.0-rc1/bin/julia /usr/local/bin/julia

RUN --mount=type=ssh xvfb-run -a -s '-screen 0 1024x768x24' julia -t auto -e 'using Pkg; Pkg.Registry.add([RegistrySpec(name="General")]); Pkg.update(); Pkg.add(name="GLMakie", version="0.1.28"); Pkg.add(name="FileIO", version="1.6");'

COPY plot.jl /plot.jl
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /tmp
ENTRYPOINT [ "/entrypoint.sh" ]

