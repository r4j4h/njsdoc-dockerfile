FROM dockerfile/java:oracle-java8

RUN \
    wget https://bitbucket.org/nexj/njsdoc/downloads/njsdoc-0.0.7.jar

ENTRYPOINT ["java", "-jar", "njsdoc-0.0.7.jar"]
