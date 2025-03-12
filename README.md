# CRR MQ Native HA Demonstration

This repository is to be used for creating a NativeHA MQ Queue Manager on OCP for the purposes of Demonstrating cross region recovery.
All artefacts are present for the complete demonstration.
The scripts directory contains the script for deploying the two queue managers.
<BR>
The client directory containes a keystore and CCDT along with an mqclient.ini file to support client connectivity.
Note that the CCDT host names need to be changed to reflect the OCP environment into which this is deployed, as do the remote addresses for the two '
separate Native HA queue manager instances.
