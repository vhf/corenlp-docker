FROM phusion/baseimage:latest

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install Java
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer

RUN apt-get install -y unzip

# Install CoreNLP
ENV VERSION stanford-corenlp-full-2016-10-31
RUN mkdir -p /opt/corenlp
WORKDIR /opt/corenlp
RUN wget --quiet http://nlp.stanford.edu/software/$VERSION.zip -O corenlp.zip
RUN unzip corenlp.zip
RUN mv $VERSION src
RUN rm -r corenlp.zip

# Add service
RUN mkdir /etc/service/corenlp
ADD corenlp.sh /etc/service/corenlp/run
EXPOSE 9000

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache
