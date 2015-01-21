FROM node:0.10
MAINTAINER Daniel Dent (https://www.danieldent.com/)

ENV METEOR_VERSION 1.0.1
ENV METEOR_INSTALLER_SHA256 56737bd411f136e35cea34681db3ceabc10ee00f98371b9fee5270102ace7a3c
ENV METEOR_LINUX_X86_32_SHA256 df48d2bb09c818fa7ad62bfc9a649e0e9132146a756928713f3443b91f74a0ce
ENV METEOR_LINUX_X86_64_SHA256 bd8976dbbe3719a5a26d4064685ea8ef70d21086d5a3fad6ebd380a476878ceb
ENV TARBALL_URL_OVERRIDE https://github.com/DanielDent/docker-meteor/releases/download/v${RELEASE}/meteor-bootstrap-${PLATFORM}-${RELEASE}.tar.gz

# 1. Download & verify the meteor installer.
# 2. Patch it to validate the meteor tarball's checksums.
# 3. Install meteor

COPY meteor-installer.patch /tmp/meteor/meteor-installer.patch
COPY vboxsf-shim.sh /usr/local/bin/vboxsf-shim
RUN curl -SL https://github.com/DanielDent/docker-meteor/releases/download/v1.0.1/installer-1.0.1.sh -o /tmp/meteor/inst \
    && sed -e "s/^RELEASE=.*/RELEASE=\"\$METEOR_VERSION\"/" /tmp/meteor/inst > /tmp/meteor/inst-canonical \
    && echo $METEOR_INSTALLER_SHA256 /tmp/meteor/inst-canonical | sha256sum -c \
    && patch /tmp/meteor/inst /tmp/meteor/meteor-installer.patch \
    && chmod +x /tmp/meteor/inst \
    && /tmp/meteor/inst \
    && rm -rf /tmp/meteor

# 4. Install demeteorizer (using my fork of demeteorizer until Dockerfile support is merged upstream)

RUN npm install -g DanielDent/demeteorizer#v2.1.0 \
    && npm cache clear

VOLUME /app
WORKDIR /app
EXPOSE 3000
CMD [ "meteor" ]
