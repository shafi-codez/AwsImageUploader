<!DOCTYPE html>
<?php
#retrieve these values that were set in process.php to make our code more flexible

require 'vendor/autoload.php';

use Aws\SimpleDb\SimpleDbClient;
use Aws\S3\S3Client;
use Aws\Sqs\SqsClient;
use Aws\Common\Aws;
use Aws\SimpleDb\Exception\InvalidQueryExpressionException;

//aws factory
$aws = Aws::factory('/var/www/vendor/aws/aws-sdk-php/src/Aws/Common/Resources/custom-config.php');

// Instantiate the S3 client with your AWS credentials and desired AWS region
$client = $aws->get('S3');

$sdbclient = $aws->get('SimpleDb');

$sqsclient = $aws->get('Sqs');

$mbody="";

$s3urlprefix = 'https://s3.amazonaws.com/';
$localfilename = "./sample.png";
/*$result = $client->getObject(array(
    'Bucket' => 'shafi-hawk.iit.edu1380214201',
    'Key'    => 'talk.jpg',
    'SaveAs' => $localfilename,
));*/

addStamp($localfilename);

#########################################################################
# PHP function for adding a "stamp" or watermark through the php gd library
#########################################################################
function addStamp($image)
{

    // Load the stamp and the photo to apply the watermark to
    // http://php.net/manual/en/function.imagecreatefromgif.php
    $stamp = imagecreatefromgif("./happy_trans.gif");
    $im = imagecreatefrompng($image);

    // Set the margins for the stamp and get the height/width of the stamp image
    $marge_right = 10;
    $marge_bottom = 10;
    $sx = imagesx($stamp);
    $sy = 
            imagesy($stamp);

    // Copy the stamp image onto our photo using the margin offsets and the photo 
    // width to calculate positioning of the stamp. 
    imagecopy($im, $stamp, imagesx($im) - $sx - $marge_right, imagesy($im) - $sy - $marge_bottom, 0, 0, imagesx($stamp), imagesy($stamp));

    # (Commented) This cannot be here, problems with outputing resize.php as HTML
    # header('Content-type: image/png');

    // Output and free memory
    imagepng($im, "./test.png");
    imagedestroy($im);
    imagedestroy($stamp);
}

?>
<html>
<head><title>Resize PHP</title></head>
<body><? echo $localfilename ?>

<img src="./test.png" />

</body>
</html>
