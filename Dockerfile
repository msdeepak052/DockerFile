FROM ubuntu:24.10

RUN sudo apt install default-jre

ENV JENKINS_HOME /var/jenkins_home

RUN wget https://get.jenkins.io/war-stable/2.452.1/jenkins.war

WORKDIR ${JENKINS_HOME}

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG http_port=8080
ARG agent_port=50000

RUN groupadd -g ${gid} ${group} \
    && useradd -d "$JENKINS_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

RUN chown -R ${user} "$JENKINS_HOME" /usr/share/jenkins/ref	

USER ${user}

CMD["java","-jar","jenkins.war"]
