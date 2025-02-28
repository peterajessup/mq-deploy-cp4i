#!/bin/bash
oc project mq
set +e
# Remove the runnning queue manager instance (if any)

oc delete QueueManager sydqm melqm

# Delete the route object and secret for the QueueManager keystore (if any), and the mqsc configMap
oc delete route sydroute
oc delete route melroute

oc delete secret mq1key

oc delete configMap mq1-mqsc
# oc delete persistentvolumeclaim data-mq1-ibm-mq-0 data-mq1-ibm-mq-1 data-mq1-ibm-mq-2
set -e
# Create the route and the keystore secret and mqsc configMap
oc apply -f sydRoute.yaml

oc create secret tls mqkey --cert=./tls/tls.crt --key=./tls/tls.key
# ----for CRR
oc create secret tls melkey --cert=./tls.crt --key=./tls/tls.key
oc create secret tls sydkey --cert=./tls.crt --key=./tls/tls.key
oc create secret generic tls-mel --from-file ./tls/tls.crt 
oc create secret generic tls-syd --from-file ./tls/tls.crt
#------------
oc create -f mqsc/mqsc.yaml

set -e
oc apply -f sydCrr.yaml
oc apply -f melCrr.yaml
