<!DOCTYPE html>
<?php

// Include the SDK using the Composer autoloader
require 'vendor/autoload.php';

header("Content-type: text/plain; charset=utf-8");

use Aws\SimpleDb\SimpleDbClient;
use Aws\S3\S3Client;
use Aws\Sns\SnsClient;
use Aws\Sns\Exception\InvalidParameterException;
use Aws\Common\Aws;
// Instantiate the S3 client with your AWS credentials and desired AWS regionws\Common\Aws;

//aws factory
$aws = Aws::factory('/var/www/vendor/aws/aws-sdk-php/src/Aws/Common/Resources/custom-config.php');

$client = $aws->get('S3');

$sdbclient = $aws->get('SimpleDb');

$snsclient = $aws->get('Sns');


?>