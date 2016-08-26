# Copyright 2016 The Kubernetes Authors All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM registry.dataos.io/library/cassandra:2.1.11

RUN sed -i "s/http:\/\/httpredir.debian.org/http:\/\/mirrors.aliyun.com/g" /etc/apt/sources.list && \
    sed -i "s/http:\/\/security.debian.org/http:\/\/mirrors.aliyun.com\/debian-security/g" /etc/apt/sources.list
    
COPY run.sh /run.sh

RUN chmod a+rx /run.sh && \
  mkdir -p /cassandra_data/data && \
  chown -R cassandra:cassandra /etc/cassandra /cassandra_data && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /usr/share/doc/ && \
  rm -rf /usr/share/doc-base/ && \
  rm -rf /usr/share/man/ && \
  rm -rf /tmp/* 

COPY cassandra.yaml /etc/cassandra/cassandra.yaml
COPY logback.xml /etc/cassandra/logback.xml
COPY kubernetes-cassandra.jar /kubernetes-cassandra.jar
COPY status_check.sh /status_check.sh

VOLUME ["/cassandra_data"]    

USER cassandra

CMD /run.sh
