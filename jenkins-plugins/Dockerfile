ARG JENKINS_VERSION=lts
FROM jenkins/jenkins:${JENKINS_VERSION}

LABEL Description="This image aims to test dashboards plugin in a Jenkins instance" 

# Install useful plugins from file
# This kind of file can be created with "export-plugins-list.sh" script
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Disable banner to install additionnal plugins
# https://github.com/jenkinsci/docker/blob/master/README.md
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"

# Configuration-as-Code
ENV CASC_JENKINS_CONFIG /var/jenkins_casc
COPY --chown=jenkins casc ${CASC_JENKINS_CONFIG}