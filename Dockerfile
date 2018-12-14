FROM mongo:3.6.7-stretch

MAINTAINER <Renato Ruis> renatoruis@gmail.com

ADD run.sh /run.sh
ADD configMongo.sh /configMongo.sh

RUN chmod +x /run.sh
RUN chmod +x /configMongo.sh


EXPOSE 27017

ENTRYPOINT ["/bin/bash", "/run.sh"]

