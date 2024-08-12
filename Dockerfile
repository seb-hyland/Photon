    FROM alpine AS emacs-builder

    RUN apk update

    RUN \
    apk add --no-cache \
    git \
    cmake \
    gcc \
    build-base \
    libgccjit-dev \
    autoconf \
    texinfo \
    jansson-dev \
    gtk+3.0-dev \
    webkit2gtk-dev \
    gnutls-dev \
    tree-sitter-dev

    RUN \
    apk add --no-cache \
    alsa-lib \
    cairo \
    dbus-libs \
    desktop-file-utils \
    fontconfig \
    freetype \
    gdk-pixbuf \
    giflib \
    glib \
    gmp \
    harfbuzz \
    hicolor-icon-theme \
    libjpeg-turbo \
    libncursesw \
    libpng \
    librsvg-dev \
    libwebpdecoder \
    libwebpdemux \
    libxml2 \
    musl \
    pango \
    sqlite-libs \
    tiff \
    zlib

    WORKDIR /tmp
    RUN git clone --depth 1 -b emacs-30 https://git.savannah.gnu.org/git/emacs.git

    WORKDIR /tmp/emacs
     RUN ./autogen.sh \
      && ./configure \
    --prefix=/opt/emacs \
    --with-json --with-native-compilation=aot --with-xwidgets --with-pgtk \
    'CFLAGS=-O2' \
    'LDFLAGS=-Wl,--as-needed,-O1,--sort-common -Wl,-z,pack-relative-relocs' \
     && make NATIVE_FULL_AOT=1 -j$(nproc) \
     && make install




    FROM alpine AS vterm-builder

    RUN apk update

    RUN \
    apk add --no-cache \
    git \
    cmake \
    gcc \
    build-base \
    libtool \
    perl

    RUN \
    git clone https://github.com/akermu/emacs-libvterm.git /tmp/emacs-libvterm && \
    mkdir -p /tmp/emacs-libvterm/build

    WORKDIR /tmp/emacs-libvterm/build

    RUN \
    cmake .. && \
    make
    



    FROM alpine AS photon-final

    # System setup ====================

    RUN \
    apk update

    RUN \
    apk add --no-cache \
    alsa-lib \
    cairo \
    dbus-libs \
    desktop-file-utils \
    fontconfig \
    freetype \
    gdk-pixbuf \
    giflib \
    glib \
    gmp \
    gnutls \
    gtk+3.0 \
    harfbuzz \
    hicolor-icon-theme \
    jansson \
    libgccjit \
    libjpeg-turbo \
    libncursesw \
    libpng \
    librsvg \
    libwebpdecoder \
    libwebpdemux \
    libxml2 \
    musl \
    pango \
    sqlite-libs \
    tiff \
    webkit2gtk \
    zlib

    COPY --from=emacs-builder /opt/emacs /opt/emacs
    ENV PATH="$PATH:/opt/emacs/bin"

    RUN \
    apk add --no-cache \
    gcc \
    musl-dev \
    git \
    curl \
    cmake \
    openssh \
    npm \
    bash \
    fish \
    openssh \
    mesa-vulkan-swrast
    
    RUN apk add simp1e-cursors-snow simp1e-cursors-dark --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ && gsettings set org.gnome.desktop.interface cursor-theme 'simp1e-cursors-snow'

    # Install language dependencies ====================

    RUN \
    apk add --no-cache \
    python3 \
    py3-pip \
    octave 
    #    rust \
    #    cargo \
    #    rustfmt \
    #    rust-analyzer \
    #    alpine-sdk \
    ##   webkit2gtk-dev \
    #    openssl-dev \
    #    file \
    #    gtk+3.0-dev \
    #    libayatana-appindicator-dev \
    #    librsvg-dev \
    #    vips-dev
    #
    #RUN apk add tauri-cli --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/
    #RUN apk add libappindicator-dev --repository=http://dl-cdn.alpinelinux.org/alpine/v3.17/community/


    RUN \
    apk add --no-cache \
    tree-sitter \
    enchant2-dev \
    nuspell \
    pandoc \
    ripgrep \
    starship 


    RUN ln -sf python3 /usr/bin/python

    RUN npm install -g git+https://gitlab.com/matsievskiysv/math-preview


    # Install Tectonic (LaTeX environment) ====================
    WORKDIR /usr/local/bin
    RUN curl --proto '=https' --tlsv1.2 -fsSL https://drop-sh.fullyjustified.net | sh


    # Copy fonts and config files into container ====================
    COPY --from=vterm-builder /tmp/emacs-libvterm/vterm-module.so /root/.emacs.d/vterm/vterm-module.so
    COPY --from=vterm-builder /tmp/emacs-libvterm/vterm.el /root/.emacs.d/vterm/vterm.el
    COPY fonts/ /usr/share/fonts/
    COPY init.el /root/.emacs.d/init.el
    COPY add-ons /root/.emacs.d/add-ons
    COPY snippets /root/.emacs.d/snippets-core/
    COPY add-ons/elpa-tree-sitter/tree-sitter-20220212.1632 /root/.emacs.d/elpa/tree-sitter-20220212.1632
    COPY add-ons/elpa-tree-sitter/tsc-20220212.1632 /root/.emacs.d/elpa/tsc-20220212.1632
    COPY config.fish /root/.config/fish/config.fish
    COPY starship.toml /root/.config/starship.toml
    COPY dictionaries/en_CA.aff /root/.config/enchant/nuspell/en_CA.aff
    COPY dictionaries/en_CA.dic /root/.config/enchant/nuspell/en_CA.dic

    RUN ln -s /Local/Documents/Photon/keychain/.gitconfig /root/.gitconfig && \
    	ln -s /Local/Documents/Photon/sys/dictionary.dic /root/.config/enchant/en_CA.dic

    ENV DISPLAY=host.docker.internal:0.0

    WORKDIR /Local
    # ENTRYPOINT ["emacs"]
