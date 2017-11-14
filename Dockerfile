FROM ubuntu:16.04

MAINTAINER Rory McCune <rorym@mccune.org.uk>

WORKDIR /opt/

#General packages and pre-reqs for tools like Metasploit
RUN apt-get update && apt-get install -y \
	build-essential \
	git-core \
	subversion \
	vim \
	wget \
	smbclient \
	nfs-common \
	rsh-client \
	whois \
	snmp \
	libreadline-dev \
	libpq5 \
	libpq-dev \
	libreadline5 \
	libsqlite3-dev \
	libpcap-dev \
	autoconf \
	postgresql \
	pgadmin3 \
	curl \
	zlib1g-dev \
	libxml2-dev \
	libxslt1-dev \
	vncviewer \
	libyaml-dev \
	ssh \
	slurm \
	curl \
	libssl-dev

#Install Ruby
RUN curl -fSL -o ruby.tar.gz "http://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz" \
	&& mkdir -p /usr/src/ruby \
	&& tar -xzf ruby.tar.gz -C /usr/src/ruby --strip-components=1 \
	&& rm ruby.tar.gz \
	&& cd /usr/src/ruby \
	&& ./configure --disable-install-doc \
	&& make -j"$(nproc)" \
	&& make install \
	&& gem update --system $RUBYGEMS_VERSION \
	&& rm -r /usr/src/ruby

#Install nmap
RUN git clone --depth=1 https://github.com/nmap/nmap.git && \
	cd nmap && \
	./configure --without-zenmap && \
	make && \
	make install && \
	rm -rf ../nmap

#Install Metasploit
RUN git clone --depth=1 https://github.com/rapid7/metasploit-framework.git && \
	cd metasploit-framework && \
	gem install bundler && \
	bundle install 

#Install Testing Scripts
RUN git clone --depth=1 https://github.com/raesene/TestingScripts.git && \
	cd TestingScripts && \
	bundle install


#Install Nikto Pre-reqs
RUN apt-get install -y \
	libnet-ssleay-perl

#Install Nikto
RUN git clone --depth=1 https://github.com/sullo/nikto.git && \
	cd nikto/program && \
	./nikto.pl -update

#Install SecLists
#RUN git clone https://github.com/danielmiessler/SecLists.git
