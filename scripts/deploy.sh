#!/bin/bash

set +e

# --------For the DR site-------------
oc project mqdr
oc delete QueueManager melqm
oc delete secret mqkey melkey tls-mel
oc delete configMap mq1-mqsc
oc delete route melroute

set -e
oc apply -f melRoute.yaml

oc create secret tls mqkey --cert=./tls/tls.crt --key=./tls/tls.key
# Key and cert for CRR
oc create secret tls melkey --cert=./tls.crt --key=./tls/tls.key
oc create secret generic tls-mel --from-file ./tls/tls.crt 

oc create -f mqsc/mqsc.yaml
oc apply -f melCrr.yaml
# ----------------------------------

# --------For the Live site-------------
set +e
oc project mq

oc delete QueueManager sydqm 
oc delete route sydroute 
oc delete secret mqkey sydkey tls-syd
oc delete configMap mq1-mqsc

set -e
oc apply -f sydRoute.yaml

oc create secret tls mqkey --cert=./tls/tls.crt --key=./tls/tls.key

# Key and cert for CRR
oc create secret tls sydkey --cert=./tls.crt --key=./tls/tls.key
oc create secret generic tls-syd --from-file ./tls/tls.crt

oc create -f mqsc/mqsc.yaml


oc apply -f sydCrr.yaml

