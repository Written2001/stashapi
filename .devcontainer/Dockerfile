FROM rocker/r-ver:4.5.3

ENV DEBIAN_FRONTEND=noninteractive
ENV R_LIBS_USER=/home/vscode/R/library

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        openssh-client \
        python3 \
        python3-pip \
        sudo \
        && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        gfortran \
        make \
        && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libcurl4-openssl-dev \
        libfontconfig1-dev \
        libfreetype6-dev \
        libfribidi-dev \
        libharfbuzz-dev \
        libgit2-dev \
        libicu-dev \
        libjpeg-dev \
        libpng-dev \
        libssl-dev \
        libtiff5-dev \
        libxml2-dev \
        pandoc \
        unixodbc-dev \
        zlib1g-dev \
        && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y --no-install-recommends libuv1 libuv1-dev \
    && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash vscode && \
    usermod --append --groups sudo vscode && \
    echo 'vscode ALL=(root) NOPASSWD:ALL' > /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode && \
    mkdir -p /home/vscode/R/library && \
    mkdir -p /home/vscode/.ssh && \
    printf '%s\n' \
        'Host github-stashapi' \
        '  HostName github.com' \
        '  User git' \
        '  IdentityFile ~/.ssh/id_ed25519_stashapi' \
        '  IdentitiesOnly yes' \
        > /home/vscode/.ssh/config && \
    chmod 700 /home/vscode/.ssh && \
    chmod 600 /home/vscode/.ssh/config && \
    chown -R vscode:vscode /home/vscode/.ssh && \
    chown -R vscode:vscode /home/vscode/R

USER vscode

RUN R -q -e "install.packages('renv', repos = 'https://cloud.r-project.org', lib = Sys.getenv('R_LIBS_USER'))"

COPY tools/requirements.txt /tmp/stashapi-python-requirements.txt
RUN python3 -m pip install --user --break-system-packages --no-cache-dir \
    -r /tmp/stashapi-python-requirements.txt
