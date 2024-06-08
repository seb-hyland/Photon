FROM pandoc/latex:latest

# Rust installation ----------
# RUN apk add --no-cache \
#         ca-certificates \
#         gcc
# 
# ENV RUSTUP_HOME=/usr/local/rustup \
#     CARGO_HOME=/usr/local/cargo \
#     PATH=/usr/local/cargo/bin:$PATH \
#     RUST_VERSION=1.78.0
# 
# RUN set -eux; \
#     apkArch="$(apk --print-arch)"; \
#     case "$apkArch" in \
#         x86_64) rustArch='x86_64-unknown-linux-musl'; rustupSha256='b9d84cbba1ed29d11c534406a1839d64274d29805041e0e096d5293ae6390dd0' ;; \
#         aarch64) rustArch='aarch64-unknown-linux-musl'; rustupSha256='841513f7599fcf89c71a62dea332337dfd4332216b60c17648d6effbeefe66a9' ;; \
#         *) echo >&2 "unsupported architecture: $apkArch"; exit 1 ;; \
#     esac; \
#     url="https://static.rust-lang.org/rustup/archive/1.27.0/${rustArch}/rustup-init"; \
#     wget "$url"; \
#     echo "${rustupSha256} *rustup-init" | sha256sum -c -; \
#     chmod +x rustup-init; \
#     ./rustup-init -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION --default-host ${rustArch}; \
#     rm rustup-init; \
#     chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
#     rustup --version; \
#     cargo --version; \
#     rustc --version;


# TeX installation -----------



# System setup ---------------

RUN \
    apk update


RUN \
    apk add --no-cache \
    emacs-x11-nativecomp \
    glib \
    gcc \
    libgccjit \
    musl-dev \
    libtool \
    gsettings-desktop-schemas \
    git \
    curl \
    cmake \
    make \
    openssh \
    npm \
    bash \
    zsh \
    perl \
    wget \
    jwm 

RUN \
    apk add --no-cache \
    python3 \
    py3-pip \
    octave \
    rust \
    cargo \
    rustfmt \
    rust-analyzer \
    alpine-sdk \
    webkit2gtk-dev \
    openssl-dev \
    file \
    gtk+3.0-dev \
    libayatana-appindicator-dev \
    librsvg-dev \
    vips-dev


RUN \
    apk add --no-cache \
    chromium-swiftshader \
    tree-sitter \
    aspell \
    aspell-en \
    ripgrep \
    starship

RUN apk add tauri-cli --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/

RUN apk add libappindicator-dev --repository=http://dl-cdn.alpinelinux.org/alpine/v3.15/community/


RUN ln -sf python3 /usr/bin/python 
RUN npm install -g npm@10.7.0 && npm install -g git+https://gitlab.com/matsievskiysv/math-preview
#RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# ENV PATH="$PATH:/root/.cargo/bin"

COPY fonts/ /usr/share/fonts/

COPY init.el /root/.emacs.d/init.el
COPY add-ons /root/.emacs.d/add-ons
COPY snippets /root/.emacs.d/snippets-core/
COPY add-ons/elpa-tree-sitter/tree-sitter-20220212.1632 /root/.emacs.d/elpa/tree-sitter-20220212.1632
COPY add-ons/elpa-tree-sitter/tree-sitter-langs-20240602.731 /root/.emacs.d/elpa/tree-sitter-langs-20240602.731
COPY add-ons/elpa-tree-sitter/tsc-20220212.1632 /root/.emacs.d/elpa/tsc-20220212.1632
COPY .zshrc /root/.zshrc
COPY starship.toml /root/.config/starship.toml
COPY chromium.conf /etc/chromium/chromium.conf

ENV CHROME_BIN=/usr/bin/chromium \
    CHROME_PATH=/usr/lib/chromium/

ENV DISPLAY=host.docker.internal:0.0

ENTRYPOINT ["emacs"]
