FROM ubuntu:16.04
LABEL  maintainer "UrmnafBortHyuga <yurihyuga1889@gmail.com>"

RUN dpkg --add-architecture i386

# Install Packages
RUN apt-get update
RUN apt-get install -y curl zip unzip git wget apt-transport-https
RUN apt-get install -y --no-install-recommends chromium-browser chromium-chromedriver
RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add -
RUN echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list
RUN apt-get update
RUN apt-get install cf-cli
RUN apt-get clean && rm -rf /var/lib/apt/list

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get --quiet install --yes nodejs
RUN npm i -g @angular/cli

# Set up chromium
ENV CHROME_BIN /usr/bin/chromium-browser
ENV CHROMIUM_FLAGS "--disable-gpu --no-sandbox --headless"
RUN ln -s /usr/lib/chromium-browser/chromedriver /usr/bin/
RUN rm /etc/chromium-browser/default
