FROM debian

RUN apt-get -y update && apt-get install -y \
	ca-certificates \
	git \
	openssh-client \
	python-yaml \
	python-jinja2 \
	python-httplib2 \
	python-keyczar \
	python-paramiko \
	python-setuptools \
	python-pkg-resources \
	python-pip

# Ansible
RUN mkdir /etc/ansible/
RUN echo '[local]\nlocalhost\n' > /etc/ansible/hosts
RUN mkdir -p /opt/ansible/
RUN git clone http://github.com/ansible/ansible.git /opt/ansible
WORKDIR /opt/ansible
# RUN git submodule update --init
RUN git rm -rf lib/ansible/modules/core
RUN git submodule add --name lib/ansible/modules/core https://github.com/fluciotto/ansible-modules-core.git lib/ansible/modules/core
RUN git rm -rf v2/ansible/modules/core
RUN git submodule add --name v2/ansible/modules/core https://github.com/fluciotto/ansible-modules-core.git v2/ansible/modules/core

ENV PATH /opt/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin
ENV PYTHONPATH /opt/ansible/lib
ENV ANSIBLE_LIBRARY /opt/ansible/library

# Libcloud
RUN easy_install pip
RUN pip install apache-libcloud
