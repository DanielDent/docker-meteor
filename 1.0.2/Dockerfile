FROM node:0.10
MAINTAINER Daniel Dent (https://www.danieldent.com/)

ENV METEOR_VERSION 1.0.2
ENV METEOR_INSTALLER_SHA256 56737bd411f136e35cea34681db3ceabc10ee00f98371b9fee5270102ace7a3c
ENV METEOR_LINUX_X86_32_SHA256 6d4a05171951f6e9182a052afccab8ea9fc1da1cc08ea5774b961bf18b4f9f04
ENV METEOR_LINUX_X86_64_SHA256 a1e6622a843d45bb883d43679751041dcd06d9b7ee6b2058b6fd3fd030669011
ENV TARBALL_URL_OVERRIDE https://github.com/DanielDent/docker-meteor/releases/download/v${RELEASE}/meteor-bootstrap-${PLATFORM}-${RELEASE}.tar.gz

# 1. Download & verify the meteor installer.
# 2. Patch it to validate the meteor tarball's checksums.
# 3. Install meteor

COPY meteor-installer.patch /tmp/meteor/meteor-installer.patch
COPY vboxsf-shim.sh /usr/local/bin/vboxsf-shim
RUN curl -SL https://github.com/DanielDent/docker-meteor/releases/download/v1.0.2/installer-1.0.2.sh -o /tmp/meteor/inst \
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
