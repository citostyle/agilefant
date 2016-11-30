FROM tomcat:8-jre8
MAINTAINER Juergen Cito <cito@ifi.uzh.ch>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && apt-get -qqy install ttf-dejavu \
&& rm -rf /var/lib/apt/lists/*

ENV AF_WAR      webapp/target/agilefant.war
ENV AF_UNWAR    /tmp/agilefant/
ENV AF_CONFIG   $AF_UNWAR/WEB-INF/agilefant.conf
ENV DESTINATION /usr/local/tomcat/webapps/

ENV CATALINA_OPTS  -javaagent:webapps/agilefant/WEB-INF/lib/kieker-1.12-aspectj.jar \
                   -Dkieker.monitoring.configuration=kieker.monitoring.properties \
                   -Dkieker.monitoring.skipDefaultAOPConfiguration=true \
                   -Dkieker.monitoring.writer.filesystem.AsyncFsWriter.customStoragePath=/tmp \
                   -Dkieker.common.logging.Log=JDK \
                   -Daj.weaving.verbose=true \
                   -Dorg.aspectj.weaver.showWeaveInfo=true

RUN mkdir -p /tmp /opt /app
ADD entrypoint.sh /opt/entrypoint.sh
ADD setenv.sh /usr/local/tomcat/bin/setenv.sh
ADD $AF_WAR /tmp

RUN cd /tmp \
&& unzip -d "$AF_UNWAR" agilefant.war \
&& cd "$AF_UNWAR" \
&& sed -i -e"s/localhost/db/" "$AF_CONFIG" \
&& cp -r "$AF_UNWAR" "$DESTINATION"


VOLUME /tmp

EXPOSE 8080

ENTRYPOINT /opt/entrypoint.sh

