<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Welcome to CodeIgniter</title>

    <style type="text/css">

    ::selection { background-color: #E13300; color: white; }
    ::-moz-selection { background-color: #E13300; color: white; }

    body {
        background-color: #FFF;
        margin: 40px;
        font: 16px/20px normal Helvetica, Arial, sans-serif;
        color: #4F5155;
        word-wrap: break-word;
    }

    a {
        color: #003399;
        background-color: transparent;
        font-weight: normal;
    }

    h1 {
        color: #444;
        background-color: transparent;
        border-bottom: 1px solid #D0D0D0;
        font-size: 24px;
        font-weight: normal;
        margin: 0 0 14px 0;
        padding: 14px 15px 10px 15px;
    }

    code {
        font-family: Consolas, Monaco, Courier New, Courier, monospace;
        font-size: 16px;
        background-color: #f9f9f9;
        border: 1px solid #D0D0D0;
        color: #002166;
        display: block;
        margin: 14px 0 14px 0;
        padding: 12px 10px 12px 10px;
    }

    #body {
        margin: 0 15px 0 15px;
    }

    p.footer {
        text-align: right;
        font-size: 16px;
        border-top: 1px solid #D0D0D0;
        line-height: 32px;
        padding: 0 10px 0 10px;
        margin: 20px 0 0 0;
    }

    #container {
        margin: 10px;
        border: 1px solid #D0D0D0;
        box-shadow: 0 0 8px #D0D0D0;
    }
    </style>
</head>
<body>

<div id="container">
    <div id="body">
        <strong>Parameters :</strong><p style="color:red">userEmail, userPassword, deviceId, deviceType</p>
		<strong>Method :</strong><p style="color:red">POST</p>
		<strong>Hitting Url :</strong><p style="color:red">http://www.rockonit.com/docmein/v1/app/registeruser</p>
        <p>App Register </p>
        <form action = "<?php echo base_url('v1/app/registeruser'); ?>" method = "post">
        User Email :    <input type = "email" name ="userEmail" placehoder = "user email"><br>
        User Password : <input type = "password" name ="userPassword" placehoder = "user password"><br>
        User DeviceId (APNS or GCM) :   <input type = "text" name ="deviceId" placehoder = "device Id"><br>
        User DeviceType :   <input type = "text" name ="deviceType" placehoder = "device Type"><br>
        <input type = "submit" name = "Submit" value = "Register">
        </form>

        
    </div>

    <p class="footer">Page rendered in <strong>{elapsed_time}</strong> seconds. <?php echo  (ENVIRONMENT === 'development') ?  'CodeIgniter Version <strong>' . CI_VERSION . '</strong>' : '' ?></p>
</div>

</body>
</html>
