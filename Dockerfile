FROM mongo

MAINTAINER <Renato Ruis> renatoruis@gmail.com

ADD run.sh /run.sh
ADD configMongo.sh /configMongo.sh

RUN chmod +x /run.sh
RUN chmod +x /configMongo.sh


EXPOSE 27017

CMD ["/bin/bash", "/run.sh"]

