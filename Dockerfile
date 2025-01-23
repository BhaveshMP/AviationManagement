# Use an official JDK 1.8 base image
FROM openjdk:8-jdk

# Set environment variables
ENV GLASSFISH_VERSION=4.1.1
ENV MYSQL_JAR_VERSION=8.4.0

# Install GlassFish
RUN apt-get update && apt-get install -y wget unzip \
    && wget https://download.eclipse.org/glassfish/glassfish-${GLASSFISH_VERSION}.zip -O /tmp/glassfish.zip \
    && unzip /tmp/glassfish.zip -d /opt \
    && rm /tmp/glassfish.zip \
    && mv /opt/glassfish*/ /opt/glassfish

# Copy MySQL connector JAR to GlassFish library folder
ADD https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_JAR_VERSION}.tar.gz /tmp/
RUN tar -xzf /tmp/mysql-connector-java-${MYSQL_JAR_VERSION}.tar.gz -C /tmp \
    && cp /tmp/mysql-connector-java-${MYSQL_JAR_VERSION}/mysql-connector-java-${MYSQL_JAR_VERSION}.jar /opt/glassfish/glassfish/lib/ \
    && rm -rf /tmp/*

# Expose necessary ports (4848 for admin, 8080 for HTTP)
EXPOSE 4848 8080

# Copy your project to the GlassFish deployment folder
COPY ./webpages /opt/glassfish/glassfish/domains/domain1/autodeploy/
COPY ./WEB-INF /opt/glassfish/glassfish/domains/domain1/config/

# Set the default command to start GlassFish
CMD ["/opt/glassfish/bin/asadmin", "start-domain", "--verbose"]
