FROM java:8

RUN \
    wget https://bitbucket.org/nexj/njsdoc/downloads/njsdoc-0.0.7.jar

ENTRYPOINT ["java", "-jar", "njsdoc-0.0.7.jar"]

