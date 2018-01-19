# TODO: use latest tag eventually
FROM jeffersonlab/remoll:develop

# Install aws cli tool
RUN yum -y install python-pip
RUN pip install --upgrade pip
RUN pip install awscli --upgrade --ignore-installed six

# Copy entry point helper bash script
COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["macros/runexample.mac"]

