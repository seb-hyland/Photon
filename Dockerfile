FROM archlinux:latest

RUN pacman -Syu --noconfirm && pacman -S --noconfirm \
    emacs-nativecomp \
    ttf-jetbrains-mono \
    python \
    python-pip \
    glib2 \
    texlive-basic \
    texlive-plaingeneric \
    texlive-binextra \
    texlive-fontsextra \
    texlive-latexextra \
    texlive-mathscience \
    texlive-pictures \
    texlive-lang \
    texlive-bibtexextra \
    ghostscript \
    octave \
    git \
    curl \
    chromium \
    rustup \
    tree-sitter \
    cmake \
    aspell 

RUN ln -sf python3 /usr/bin/python

COPY init.el /root/.emacs.d/init.el
COPY add-ons /root/.emacs.d/add-ons
COPY snippets /root/.emacs.d/snippets
COPY fonts/ /usr/local/share/fonts/

ENV CHROME_BIN=/usr/bin/chromium \
    CHROME_PATH=/usr/lib/chromium/ \
    CHROMIUM_FLAGS="--disable-software-rasterizer --disable-dev-shm-usage --no-sandbox --test-type --disable-gpu"

ENV DISPLAY=host.docker.internal:0.0

ENTRYPOINT ["emacs"]