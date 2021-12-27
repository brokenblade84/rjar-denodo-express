# Docker file for the Denodo express Instance.
FROM debian:stable as builder

ENV DENODO_HOME=/opt/denodo
ENV PATH="${DENODO_HOME}/jre/bin:${PATH}"

# The Denodo installation requires the uncompressed denodo installer and
# an install.xml file for unattended installation.
COPY ./denodo-express-install-8_0-linux64 /opt/denodo-install
COPY ./auto-installer.xml /opt/denodo-install/install.xml

WORKDIR /opt/denodo-install
RUN chmod +x installer_cli.sh
RUN ./installer_cli.sh install --autoinstaller install.xml

# Modify the vqlserver start script to wait for vqlserver to exit (so
# the container does not die upon start)
RUN sed -i "s/exit 0/wait/g" ${DENODO_HOME}/bin/vqlserver.sh

## Multi-step built to reduce the size of the final image
FROM debian:stable

ENV DENODO_HOME=/opt/denodo
ENV PATH="${DENODO_HOME}/jre/bin:${PATH}"

# Copy Denodo Platform from the builder image to the end image
COPY --from=builder $DENODO_HOME $DENODO_HOME

# Sets the workdir for the rest of the script
WORKDIR $DENODO_HOME

# The following ports used by VDP are exposed:
# 9999 - Denodo (JDBC, AdminTool, ...)
# 9997 & 9995 RMI/JMX (Both are JMX ports for Denodo 8.0. 9997 is JDBC for Denodo 7.0. Only expose 9995 incase of Denodo 8.0)
# 9996 - ODBC
# 9090 - Web Services
EXPOSE 9999 9997 9996 9090 9995

CMD ${DENODO_HOME}/bin/vqlserver.sh startup

# Example docker run command (Include 9995 for Denodo 8.0 only):
# docker run -d -h localhost -p 9999:9999 -p 9997:9997 -p 9996:9996 -p 9995:9995 -p 9090:9090 -v ./src/denodo/denodo-licence.lic:/opt/denodo/conf/denodo.lic denodo-image