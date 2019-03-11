<?php
$dir_data = opendir(".");
$body = "";
while ($file = readdir($dir_data)) {
	if (preg_match("/.swf/", $file)) {
		list ($width, $height, $type, $attr) = getImagesize($file);
		$body .= '<input type="button" value="'.$file.'" onclick="embed(\''.$file.'\','.$width.','.$height.')" />';
	}
}
closedir($dir_data);
?>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
        <title>Lance Showcase</title>
        <script type="text/javascript" src="showcase/swfobject.js">
        </script>
        <script type="text/javascript">
        	function embed(fileName, width, height){
				var t = document.getElementById("title");
				t.innerHTML = fileName;
				swfobject.embedSWF(fileName, "showcase", width, height, "9.0.0", "showcase/expressInstall.swf");
            }
        </script>
        <style type="text/css">
            body {
                color: #ffffff;
                font-weight: bold;
                background-color: #222222;
            }
			input {
				margin:3px;
			}
        </style>
    </head>
    <body onload="embed('AddChildTest.swf', 550, 400)">
    	<div id="title"></div>
        <div id="showcase">
            <h1>Alternative content</h1>
            <p>
                <a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a>
            </p>
        </div>
		<br />
		<br />
        <? echo $body; ?>
    </body>
</html>