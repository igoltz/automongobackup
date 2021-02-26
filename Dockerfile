#FROM mongo
#FROM registry.redhat.io/rhscl/mongodb-36-rhel7
FROM registry.access.redhat.com/rhscl/mongodb-36-rhel7

LABEL maintainer="Immo.Goltz@goethe.de"

USER root

ENV APPDIR="/opt/backup"
ENV DUMPDIR="/var/backups/mongodb"

WORKDIR ${APPDIR}

RUN whoami && \
    mkdir -p ${APPDIR} && \
    mkdir -p ${DUMPDIR} && \
    chgrp -R 0 ${DUMPDIR} && \
    chmod -R g=u ${DUMPDIR}

COPY src/automongobackup.sh ${APPDIR}
COPY etc/default/automongobackup /etc/default/

USER mongodb

CMD  ["/bin/bash", "-c", "${APPDIR}/automongobackup.sh"]
