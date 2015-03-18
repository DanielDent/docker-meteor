FROM node:0.10
MAINTAINER Daniel Dent (https://www.danieldent.com/)

ENV METEOR_VERSION 1.0.4
ENV METEOR_INSTALLER_SHA256 4020ef4d3bc257cd570b5b2d49e3490699c52d0fd98453e29b7addfbdfba9c80
ENV METEOR_LINUX_X86_32_SHA256 b267f8d7c04ad4e24e6af4dc866d776ad6f09b4a37e29a83bb5932eaddc8bd2e
ENV METEOR_LINUX_X86_64_SHA256 6da2c8b50241dfb2261930546d53c367d05d8a4a62c1f84d4f2e2b8fe549ee19

# 1. Download & verify the meteor installer.
# 2. Patch it to validate the meteor tarball's checksums.
# 3. Install meteor

COPY meteor-installer.patch /tmp/meteor/meteor-installer.patch
COPY vboxsf-shim.sh /usr/local/bin/vboxsf-shim
RUN curl -SL https://install.meteor.com/ -o /tmp/meteor/inst \
    && sed -e "s/^RELEASE=.*/RELEASE=\"\$METEOR_VERSION\"/" /tmp/meteor/inst > /tmp/meteor/inst-canonical \
    && echo $METEOR_INSTALLER_SHA256 /tmp/meteor/inst-canonical | sha256sum -c \
    && patch /tmp/meteor/inst /tmp/meteor/meteor-installer.patch \
    && chmod +x /tmp/meteor/inst \
    && /tmp/meteor/inst \
    && rm -rf /tmp/meteor

VOLUME /app
WORKDIR /app
EXPOSE 3000
CMD [ "meteor" ]
