#!/bin/bash

##########################################################################
# This code creates a Elastic Load Balancer on AWS and reports its URL to us
##########################################################################
ELBVAR=`aws elb create-load-balancer --load-balancer-name mp1elb --listeners --listeners Protocol=HTTP,LoadBalancerPort=80,InstancePort=80 --availability-zones=us-east-1a --output text`

echo $ELBVAR
#sleep 60 
for i in {0..25}; do echo -ne '.'; sleep 1;done
echo -e "\nFinished launching ELB and sleeping 60 seconds"
#########################################################################
#  This code configures the health check and how and what to load balance on
##########################################################################
aws elb configure-health-check --load-balancer-name mp1elb --health-check Target=HTTP:80/index.php,Interval=30,Timeout=5,UnhealthyThreshold=2,HealthyThreshold=10
#sleep 30 
for i in {0..25}; do echo -ne '.'; sleep 1;done
echo -e "\nFinished ELB health check and sleeping 30 seconds"
#########################################################################
# This code declares an array called INSTANCEID and launches two instances and places their instance-ids into an array for further use
########################################################################
declare -a INSTANCEID 
INSTANCEID=(`aws ec2 run-instances --image-id  ami-418fdc28 --count 2 --instance-type t1.micro --user-data file://install-private-repo.sh --key-name itm544 --security-groups default --placement AvailabilityZone=us-east-1c --output text | awk {'print $8 '}`)
#sleep 120 
for i in {0..25}; do echo -ne '.'; sleep 1;done
echo -e "\nFinished ec2 run-instances and recording instance-ids into an array"
###########################################################################
# This will describe all instances that were launched with your keypair, look for lines with ec2 in it - awk the first column to get the public DNS names and then input those to a Bash array
##########################################################################
declare -a ARRAY
ARRAY=(`aws ec2 describe-instances --filters Name=key-name,Values=544useast --output text | grep ec2 | awk {' print $1'}`)
#sleep 180 
for i in {0..30}; do echo -ne '.'; sleep 1;done
echo -e "\nFinished placing the public DNS into an array" 
######################################################################
##This use a for loop to loop through your instances (2 in this case) and will copy your private key from your local system to both of your EC2-instances so that you can pull code from the private repository
######################################################################
for i in {0,1}; do scp -o stricthostkeychecking=no -i ./544useast.priv -vv /home/controller/.ssh/id_rsa ubuntu@${ARRAY[i]}:/tmp;done 
#sleep 60
for i in {0..59}; do echo -ne '.'; sleep 1;done
echo -e "\nFinished moving your private key up to the EC2 instance and sleeping 60"
############################################################################
# This portion takes the instance-ids from 2 steps above and registers the instance-ids with the load balancer
#############################################################################
aws elb register-instances-with-load-balancer --load-balancer-name mp1elb --instances ${INSTANCEID[0]} ${INSTANCEID[1]} 

#sleep 30
for i in {0..29}; do echo -ne '.'; sleep 1;done
echo -e "\nDone with registering the instances with the load balancer and sleeping 30 seconds. Give it 5 minutes before the Webbrowser launches..."
############################
# Sleep for five minutes and then launch firefox to the ELB URL
############################
#sleep 120
for i in {0..300}; do echo -ne '.'; sleep 1;done
echo -e "\nNow launching firefox with the load balancer URL"
firefox $ELBVAR & 
