<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<link rel="stylesheet" type="text/css" href="css/style.css"/>
<body>
<div style="width: 50%; margin: 0 auto;">
    <h4 class="text-info">Sorri, your mistyped something and jumped into Banana zone!</h4>

    <div>
        <input class="btn btn-primary" type="submit" value="Go back" ONCLICK="window.location.href='/'"/>
    </div>
    <div>
        <img class="image" width="200" height="375" src="http://24.media.tumblr.com/tumblr_mac1m0fkEE1rfjowdo1_500.gif"
             alt="">
    </div>


${errorMessage}
    </div>
</body>
</html>