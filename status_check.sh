#!/bin/bash
abnormal_node=$(nodetool status |grep '^[?|D]N' |awk '{print $7}') 
for i in $abnormal_node
do 
    nodetool removenode $i > /dev/null 2>&1
done
