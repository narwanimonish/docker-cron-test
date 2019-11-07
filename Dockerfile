FROM ubuntu:18.04

RUN apt-get -y update --fix-missing
RUN apt-get upgrade -y

RUN apt-get install cron -y && \
    apt-get install -y nano vim git

WORKDIR /cron-test

COPY src/ /cron-test/src/

RUN service cron start

COPY src/cron-job /etc/cron.d/cron-job

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/cron-job

# Apply cron job
RUN crontab /etc/cron.d/cron-job

CMD [ "cron" ]


