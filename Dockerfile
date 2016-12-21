FROM ubuntu

WORKDIR /opt

RUN apt-get update
RUN apt-get install -y \
 strace \
 ltrace \
 git \
 ghex \
 binutils \# gdb objdump
 wget unzip \
 xdg-utils

RUN cd /tmp \
    && apt-get install -y make gcc \
    && git clone https://github.com/radare/radare2 \
    && cd radare2 \
    && sys/install.sh

RUN cd /tmp \
    && wget http://sourceforge.net/projects/dex2jar/files/dex2jar-2.0.zip \
    && unzip dex2jar-2.0.zip \
    && cd dex2jar-2.0 \
    && chmod u+x ./*.sh \
    && mv /tmp/dex2jar-2.0 /opt/dex2jar \
ENV PATH $PATH:/opt/dex2jar

RUN wget https://github.com/java-decompiler/jd-gui/releases/download/v1.4.0/jd-gui_1.4.0-0_all.deb \
    && mkdir /usr/share/desktop-directories/ \
    && dpkg -i jd-gui_1.4.0-0_all.deb
ENV PATH $PATH:/opt/jd-gui
