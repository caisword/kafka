#!/bin/bash

if [ $# -lt 1 ];
then
  echo "USAGE: $0 classname [opts]"
  exit 1
fi

base_dir=$(dirname $0)/../..

# include kafka jars
for file in $base_dir/core/target/scala_2.8.0/*.jar;
do
  CLASSPATH=$CLASSPATH:$file
done

for file in $base_dir/contrib/hadoop-consumer/lib_managed/scala_2.8.0/compile/*.jar;
do
  CLASSPATH=$CLASSPATH:$file
done


local_dir=$(dirname $0)

# include hadoop-consumer jars
for file in $base_dir/contrib/hadoop-consumer/target/scala_2.8.0/*.jar;
do
  CLASSPATH=$CLASSPATH:$file
done

echo $CLASSPATH

CLASSPATH=dist:$CLASSPATH:${HADOOP_HOME}/conf

#if [ -z "$KAFKA_OPTS" ]; then
#  KAFKA_OPTS="-Xmx512M -server -Dcom.sun.management.jmxremote"
#fi

if [ -z "$JAVA_HOME" ]; then
  JAVA="java"
else
  JAVA="$JAVA_HOME/bin/java"
fi

$JAVA $KAFKA_OPTS -cp $CLASSPATH $@
