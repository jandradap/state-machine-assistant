#!/bin/bash

# Environment
. ./00-environment.sh

cd his-backend/

export KAFKA_SERVICE_HOST=$(oc -n ${PROJECT_NAME} get routes ${CLUSTER_NAME}-kafka-bootstrap -o=jsonpath='{.status.ingress[0].host}{"\n"}')
export KAFKA_SERVICE_PORT=$(oc -n ${PROJECT_NAME} get routes ${CLUSTER_NAME}-kafka-bootstrap -o=jsonpath='{.spec.port.targetPort}{"\n"}')

echo "${KAFKA_SERVICE_HOST}:${KAFKA_SERVICE_PORT}"

mvn spring-boot:run -Plocal
#mvn -Drun.jvmArguments="-Djavax.net.ssl.trustStore=../amq-examples/camel-kafka-demo/src/main/resources/keystore.jks -Djavax.net.ssl.trustStorePassword=password -DKAFKA_SERVICE_HOST=${KAFKA_SERVICE_HOST} -DKAFKA_SERVICE_PORT=${KAFKA_SERVICE_PORT}" clean package spring-boot:run