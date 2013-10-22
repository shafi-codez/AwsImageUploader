<!DOCTYPE html>
<?php

// Include the SDK using the Composer autoloader
require 'vendor/autoload.php';
header("Content-type: text/plain; charset=utf-8");

use Aws\SimpleDb\SimpleDbClient;
use Aws\S3\S3Client;
use Aws\Sqs\SqsClient;
use Aws\Common\Aws;

$aws = Aws::factory('/var/www/vendor/aws/aws-sdk-php/src/Aws/Common/Resources/custom-config.php');

// Instantiate the S3 client with your AWS credentials and desired AWS region
$client = $aws->get('S3');

$sdbclient = $aws->get('SimpleDb');

$sqsclient = $aws->get('Sqs');

$mbody="";


#####################################################
# SQS Read the queue for some information
#####################################################
$result = $sqsclient->receiveMessage(array(
    // QueueUrl is required
    // 	https://sqs.us-east-1.amazonaws.com/943227140367/photo_q
    'QueueUrl' => 'https://sqs.us-east-1.amazonaws.com/943227140367/photo_q',
    'MaxNumberOfMessages' => 1, 
));
######################################3
# Probably need some logic in here to handle delays)
######################################
foreach ($result->getPath('Messages/*/Body') as $messageBody) {
    // Do something with the message
    echo "MESSAGE BODY : $messageBody";
    $mbody=$messageBody;
}

##############################################
# Select from SimpleDB element where id = the id in the Queue
##############################################
#$exp="select * from itm544jrh where id='`$mbody`'";
$exp="select * from itm544jrh"; 

$result = $sdbclient->select(array(
    'SelectExpression' => $exp
));
foreach ($result['Items'] as $item) {
    echo $item['Name'] . "\n";
    var_export($item['Attributes']);
}

#$result = $sdbclient->deleteDomain(array(
 #          'DomainName' => 'itm544jrh',
#));



?>

<html>
    <head>
        <title>Query</title>
    </head>
    <body>
        <br
         Query  : <? echo $result?><br>
         messsage body  : <? echo $mbody?><br>
    </body>
</html>
