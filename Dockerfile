FROM continuumio/anaconda3:latest

RUN apt-get update
RUN pip install cufflinks

RUN useradd --create-home --home-dir /home/ds --shell /bin/bash ds
#RUN chown -R ds /opt/ds
RUN adduser ds sudo

ADD run_jupyter.sh /home/ds
RUN chmod +x /home/ds/run_jupyter.sh
RUN chown ds /home/ds/run_jupyter.sh

EXPOSE 8888
RUN usermod -a -G sudo ds
RUN echo "ds ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER ds

RUN mkdir -p /home/ds/notebooks
ENV HOME=/home/ds
ENV SHELL=/bin/bash
ENV USER=ds
VOLUME /home/ds/notebooks
WORKDIR /home/ds/notebooks

CMD ["/home/ds/run_jupyter.sh"]
