FROM alpine:latest

COPY cron /var/spool/cron/crontabs/root
COPY docker-entrypoint.sh /usr/bin/docker-entrypoint
#WORKDIR /aws-scripts-mon

RUN apk add --update perl perl-libwww perl-datetime-timezone perl-datetime perl-lwp-protocol-https perl-json perl-sys-syslog curl unzip coreutils && \
    rm -rf /var/cache/apk/* && \
    cd / && \
    curl https://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip -O && \
    unzip CloudWatchMonitoringScripts-1.2.2.zip && \
    rm CloudWatchMonitoringScripts-1.2.2.zip && \
    chmod +x /aws-scripts-mon/mon-put-instance-data.pl && \
    chmod +x /usr/bin/docker-entrypoint

ENTRYPOINT docker-entrypoint
