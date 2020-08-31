FROM 4.2.9-bionic

MAINTAINER <Renato Ruis> renatoruis@gmail.com

ADD run.sh /run.sh
ADD configMongo.sh /configMongo.sh

RUN chmod +x /run.sh
RUN chmod +x /configMongo.sh


EXPOSE 27017

ENTRYPOINT ["/bin/bash", "/run.sh"]

