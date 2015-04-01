FROM node:0.10
MAINTAINER Daniel Dent (https://www.danieldent.com/)

ENV METEOR_VERSION 1.1
ENV METEOR_INSTALLER_SHA256 4020ef4d3bc257cd570b5b2d49e3490699c52d0fd98453e29b7addfbdfba9c80
ENV METEOR_LINUX_X86_32_SHA256 a4eb24501ceeb73739125f45cb72fda57f2c2f3462a7d2bbf6424ab231e89be7
ENV METEOR_LINUX_X86_64_SHA256 93a95576ae1b41bc7d9808dd558e7e397d9ee9cab3b96e35566fc3c291062a84

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
