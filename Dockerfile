FROM ubuntu:ubuntu

RUN pip install prefect[github]
RUN sudo apt install rapper
