FROM ubuntu:16.04
LABEL  maintainer "UrmnafBortHyuga <yurihyuga1889@gmail.com>"

RUN dpkg --add-architecture i386

# Install Packages
# Fjoji
RUN apt-get update
RUN apt-get install -y curl zip unzip git wget ca-certificates-java apt-transport-https
RUN apt-get install -y --no-install-recommends chromium-browser chromium-chromedriver
RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add -
RUN echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list
RUN apt-get update
RUN apt-get install cf-cli
RUN apt-get clean && rm -rf /var/lib/apt/list

# gradle install
RUN \
   cd /usr/local && \
   curl -L https://services.gradle.org/distributions/gradle-4.10.2-bin.zip -o gradle-4.10.2-bin.zip && \
   unzip gradle-4.10.2-bin.zip && \
   rm gradle-4.10.2-bin.zip
RUN ln -sfn /usr/local/gradle-4.10.2/bin/gradle /usr/bin/

# Insatll Open JDK
ENV JVM_INSTALL_DIR=/opt/jvm
ADD ./install_java.sh ${JVM_INSTALL_DIR}/install_java.sh
RUN ${JVM_INSTALL_DIR}/install_java.sh
ENV JAVA_HOME=/usr/local/lib/jvm/java-8-openjdk-amd64

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get --quiet install --yes nodejs
RUN npm i -g @angular/cli

# Set up chromium
ENV CHROME_BIN /usr/bin/chromium-browser
ENV CHROMIUM_FLAGS "--disable-gpu --no-sandbox --headless"
RUN ln -s /usr/lib/chromium-browser/chromedriver /usr/bin/
RUN rm /etc/chromium-browser/default
