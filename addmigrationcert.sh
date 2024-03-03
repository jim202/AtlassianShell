#!/bin/bash
# This script will add the required Certs to the keystore for the server. 
#This will resolve the "PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target" error that will block JCMA or CCMA 
# 
#
#

while getopts j:k::d: flag
do
    case "${flag}" in
        j) JAVA_HOME=${OPTARG};;
        k) keystore=${OPTARG};;
        d) certdir=${OPTARG};;
    esac
done
printf "Enter keystore password: "
stty -echo
read -r keypassword
stty echo
echo ""
echo "password=$keypassword"
echo $JAVA_HOME;
echo $keystore;
echo $certdir
#Generate Cert
echo "Moving to Java bin"
cd $JAVA_HOME/bin
./keytool -printcert -sslserver rps--prod-west2--migration-orchestrator--task-data-repository.s3.us-west-2.amazonaws.com:443 -rfc >> $certdir/rps--prod-west2--migration-orchestrator.crt
echo "created rps--prod-west2--migration-orchestrator.crt"
./keytool -printcert -sslserver rps--prod-west2--migration-catalogue--migration-storage.s3.us-west-2.amazonaws.com:443 -rfc >> $certdir/rrps--prod-west2--migration-catalogue.crt
echo "created rrps--prod-west2--migration-catalogue.crt"
./keytool -printcert -sslserver rps--prod-west2--migration-catalogue--migration-storage-v2.s3.us-west-2.amazonaws.com:443 -rfc >> $certdir/rrps--prod-west2--migration-catalogue-V2.crt
echo "created rrps--prod-west2--migration-catalogue-V2.crt"
./keytool -printcert -sslserver rps--prod-east--app-migration-service--ams.s3.amazonaws.com:443 -rfc >> $certdir/rps--prod-east--app-migration-service.crt
echo "created rps--prod-east--app-migration-service.crt"
./keytool -printcert -sslserver api.media.atlassian.com:443 -rfc >> $certdir/api.media.atlassian.com.crt
echo "created api.media.atlassian.com.crt"
./keytool -printcert -sslserver api-private.atlassian.com:443 -rfc >> $certdir/api-private.atlassian.com.crt
echo "created api-private.atlassian.com.crt"
./keytool -printcert -sslserver marketplace.atlassian.com:443 -rfc >> $certdir/marketplace.atlassian.com.crt
echo "created marketplace.atlassian.com.crt"
./keytool -printcert -sslserver api.atlassian.com:443 -rfc >> $certdir/api.atlassian.com.crt
echo "created api.atlassian.com.crt"
./keytool -printcert -sslserver rps--prod-east--app-migration-service--ams.s3.amazonaws.com:443 -rfc >> $certdir/rps--prod-east--app-migration-service--ams.s3.amazonaws.com.crt
echo "created api.media.atlassian.com.crt"
./keytool -printcert -sslserver mp-module-federation.prod-east.frontend.public.atl-pass.net:443 -rfc >> $certdir/mp-module-federation.prod-east.frontend.public.atl-pass.net.crt
echo "rps--prod-east--app-migration-service--ams.s3.amazonaws.com.crt"
./keytool -printcert -sslserver rnsw.atlassian.net:443 -rfc >> $certdir/rnsw.atlassian.net.crt
echo "created rnsw.atlassian.net.crt"

#Store to keystore
./keytool -importcert -alias  rps--prod-west2--migration-orchestrator--task-data-repository.s3.us-west-2.amazonaws.com -keystore $keystore -storepass $keypassword -noprompt -file $certdir/rps--prod-west2--migration-orchestrator.crt
./keytool -importcert -alias  rps--prod-west2--migration-catalogue--migration-storage.s3.us-west-2.amazonaws.com -keystore $keystore -storepass $keypassword -noprompt -file $certdir/rrps--prod-west2--migration-catalogue.crt
./keytool -importcert -alias  rps--prod-west2--migration-catalogue--migration-storage-v2.s3.us-west-2.amazonaws.com -keystore $keystore -storepass $keypassword -noprompt -file $certdir/rrps--prod-west2--migration-catalogue-V2.crt
./keytool -importcert -alias  rps--prod-east--app-migration-service--ams.s3.amazonaws.com -keystore $keystore -storepass $keypassword -noprompt -file $certdir/rps--prod-east--app-migration-service.crt
./keytool -importcert -alias  api.media.atlassian.com -keystore $keystore -storepass $keypassword -noprompt -file $certdir/api.media.atlassian.com.crt
./keytool -importcert -alias  api-private.atlassian.com -keystore $keystore -storepass $keypassword -noprompt -file $certdir/api-private.atlassian.com.crt
./keytool -importcert -alias  marketplace.atlassian.com -keystore $keystore -storepass $keypassword -noprompt -file $certdir/marketplace.atlassian.com.crt
./keytool -importcert -alias  api.atlassian.com -keystore $keystore -storepass $keypassword -noprompt -file $certdir/api.atlassian.com.crt
./keytool -importcert -alias  rps--prod-east--app-migration-service--ams.s3.amazonaws.com -keystore $keystore -storepass $keypassword -noprompt -file $certdir/rps--prod-east--app-migration-service--ams.s3.amazonaws.com.crt
./keytool -importcert -alias  mp-module-federation.prod-east.frontend.public.atl-pass.net -keystore $keystore -storepass $keypassword -noprompt -file $certdir/mp-module-federation.prod-east.frontend.public.atl-pass.net.crt
./keytool -importcert -alias  rnsw.atlassian.net -keystore $keystore -storepass $keypassword -noprompt -file $certdir/rnsw.atlassian.net.crt