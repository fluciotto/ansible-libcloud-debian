FROM debian

RUN apt-get -y update && apt-get install -y \
	ca-certificates \
	openssh-client \
	python-dev \
	python-pip

RUN mkdir /etc/ansible/
RUN echo '[local]\nlocalhost\n' > /etc/ansible/hosts

# ENV PYTHONPATH /usr/local/lib/python2.7/dist-packages
# ENV ANSIBLE_LIBRARY /usr/local/lib/python2.7/dist-packages

RUN easy_install pip

RUN pip install ansible
RUN pip install apache-libcloud
