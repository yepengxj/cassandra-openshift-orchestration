#!/bin/bash

# Copyright 2014 The Kubernetes Authors All rights reserved.
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

perl -pi -e "s/%%ip%%/$(hostname -I)/g" /etc/cassandra/cassandra.yaml
if [ -z $cluster_name ];then
   sed -i "s/#cluster_name#/cluster_test/g" /etc/cassandra/cassandra.yaml
else
   sed -i "s/#cluster_name#/$cluster_name/g" /etc/cassandra/cassandra.yaml
fi
export CLASSPATH=/kubernetes-cassandra.jar
cassandra -f
