export ELBVAR=`aws elb create-load-balancer --load-balancer-name mp1jrh3 --listeners --listeners Protocol=HTTP,LoadBalancerPort=80,InstancePort=80 --availability-zones=us-east-1c --output text`

echo $ELBVAR
sleep 30 

aws elb configure-health-check --load-balancer-name mp1jrh3 --health-check Target=HTTP:80/index.php,Interval=30,Timeout=5,UnhealthyThreshold=2,HealthyThreshold=10
sleep 15

export ELBURL=`aws ec2 run-instances --image-id  ami-418fdc28 --count 2 --instance-type t1.micro --user-data file://install2.sh --key-name 544useast --security-groups default --placement AvailabilityZone=us-east-1c --output text | awk {'print $ '} | xargs aws elb register-instances-with-load-balancer --load-balancer-name mp1jrh3 --instances $1 $2`

sleep 15

aws ec2 --describe-instances --filter Key-Name=544useast 

