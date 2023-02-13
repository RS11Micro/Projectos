SET servidor=%1
SET local=%2
SET aplicacao=%3
TASKKILL /f /im %aplicacao%.exe
%local%/%aplicacao%.exe