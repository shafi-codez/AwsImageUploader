#!/bin/bash
# http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/SettingUp_CommandLine.html

JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64
AWS_CREDENTIAL_FILE=/var/www/script/credential-file-path.template
AWS_DEFAULT_REGION=us-east-1

export JAVA_HOME AWS_DEFAULT_REGION AWS_CREDENTIAL_FILE

#PATH=$PATH:$EC2_HOME/bin:$AWS_ELB_HOME/bin:$AWS_SNS_HOME/bin 

export PATH
