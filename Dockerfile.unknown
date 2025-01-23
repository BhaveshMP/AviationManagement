# Use the official OpenJDK 8 image as the base image
FROM openjdk:8-jdk

# Set GlassFish installation directory
ENV GLASSFISH_HOME=/opt/glassfish
ENV PATH=$PATH:$GLASSFISH_HOME/bin

# Install MySQL client (optional if only the connector is needed)
RUN apt-get update && apt-get install -y default-mysql-client && apt-get clean

# Copy your local GlassFish 4.1.1 installation to the container
COPY glassfish-4.1.1 $GLASSFISH_HOME

# Copy the WAR file to the GlassFish autodeploy directory
COPY Cloud_Computing.war $GLASSFISH_HOME/glassfish/domains/domain1/autodeploy/

# Copy the MySQL Connector JAR to GlassFish lib directory
COPY mysql-connector-j-8.4.0.jar $GLASSFISH_HOME/glassfish/lib/

# Expose the default GlassFish ports
EXPOSE 8080 4848

# Start GlassFish as the default command
CMD ["asadmin", "start-domain", "-v"]
