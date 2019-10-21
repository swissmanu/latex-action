FROM alpine:latest

RUN apk --no-cache add \
        ghostscript \
        gnupg \
        perl \
        python \
        tar \
        wget \
        xz
RUN wget https://bootstrap.pypa.io/get-pip.py \
  && python get-pip.py \
  && rm get-pip.py \
  && pip install pygments

ENV PATH="/opt/texlive/texdir/bin/x86_64-linuxmusl:${PATH}"
WORKDIR /root

COPY \
  LICENSE \
  README.md \
  entrypoint.sh \
  setup.sh \
  texlive.profile \
  texlive_pgp_keys.asc \
  /root/
RUN /root/setup.sh

ENTRYPOINT ["/root/entrypoint.sh"]
