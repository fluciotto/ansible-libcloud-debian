FROM ubuntu

RUN apt-get -y update && apt-get install -y \
	ca-certificates \
	git \
	python-yaml \
	python-jinja2 \
	python-httplib2 \
	python-keyczar \
	python-paramiko \
	python-setuptools \
	python-pkg-resources \
	python-pip \
	ssh-client

# Ansible
RUN mkdir /etc/ansible/
RUN echo '[local]\nlocalhost\n' > /etc/ansible/hosts
RUN mkdir -p /opt/ansible/
RUN git clone http://github.com/ansible/ansible.git /opt/ansible
WORKDIR /opt/ansible
RUN git checkout tags/v2.0.0.1-1
# Update submodule
RUN git rm -rf lib/ansible/modules/core
RUN git submodule add -b stable-2.0.0.1 --name lib/ansible/modules/core https://github.com/ansible/ansible-modules-core.git lib/ansible/modules/core

ENV PATH /opt/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin
ENV PYTHONPATH /opt/ansible/lib
ENV ANSIBLE_LIBRARY /opt/ansible/library

# Libcloud
RUN easy_install pip
RUN pip install apache-libcloud
