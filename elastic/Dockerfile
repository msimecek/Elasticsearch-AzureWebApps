FROM elasticsearch:7.9.1

RUN  ./bin/elasticsearch-plugin install \
    -Edefault.path.conf=/etc/elasticsearch analysis-phonetic

ADD ./java.policy /etc/java-8-openjdk/security/java.policy

RUN mkdir /etc/elasticsearch && \
    chown elasticsearch:elasticsearch /etc/elasticsearch 

ADD ./elasticsearch.yml /usr/share/elasticsearch/config
ADD ./elasticsearch-log4j2.properties /usr/share/elasticsearch/log4j2.properties
ADD ./elasticsearch-jvm.options /etc/elasticsearch/jvm.options