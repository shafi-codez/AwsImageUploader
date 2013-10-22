<!DOCTYPE html>
<html>
    <head>
        <title>AWS : Image Uploader</title>
        <link href="css/default.css" rel="stylesheet" type="text/css" />
    </head>

    <body>
        <h2>My Picture Uploader : ITM 544   </h2>
        <form action="process.php" method="post" enctype="multipart/form-data">
            Email: <input type="text" name="email" > <br />
            Cell Number: <input type="text" name="phone" > <br />
            Choose Image: <input type="file" name="uploaded_file" id="uploaded_file"> <br />  
            <input type="submit"  value="submit it!" >
        </form>
    </body>

</html>
