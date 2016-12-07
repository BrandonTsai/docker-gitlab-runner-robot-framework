# This dockerfile uses the ubuntu image
# Author: Brandon Tsai

FROM gitlab/gitlab-runner:latest

RUN export LC_ALL=C

RUN apt-get update && \
    apt-get install -qqy python-pip git unzip xvfb wget vim openssh-client

# Install Desktop
RUN apt-get install -qqy --no-install-recommends ubuntu-desktop

# Install Firefox 46.0.1
RUN apt-get autoremove -y --force-yes firefox firefox-locale-zh-hant
ADD ./firefox-mozilla-build_46.0.1-0ubuntu1_amd64.deb /tmp/
RUN dpkg -i /tmp/firefox-mozilla-build_46.0.1-0ubuntu1_amd64.deb
RUN apt-get purge -y --force-yes firefox
RUN dpkg -l | grep firefox

# Install Chrome and Chrome Driver.
ADD ./google-chrome-stable_current_amd64.deb /tmp/
RUN apt-get update && apt-get install -qqy \
    fonts-liberation \
    libappindicator1 \
    xdg-utils \
    libxss1 \
    libasound2 \
    libgconf-2-4 \
    libnspr4 \
    libnss3 \
    libpango1.0-0
RUN dpkg -i /tmp/google-chrome-stable_current_amd64.deb


RUN wget http://chromedriver.storage.googleapis.com/2.25/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN chmod 777 chromedriver
RUN mv chromedriver /usr/bin/


# Install Robot-framework

RUN pip install robotframework


# Install Selenium2Library
RUN git clone https://github.com/BrandonTsai/Selenium2Library.git
WORKDIR ./Selenium2Library/
RUN ls
RUN python setup.py install
RUN pip install "selenium == 2.53.1"

# Install webapp testing environment
WORKDIR /root/
RUN apt-get update && apt-get install -qqy \
	nodejs-legacy npm


# Gitlab-ci runer setting
ADD register-gitlab.sh /root/
ADD startup.sh /root/



