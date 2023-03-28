If you get the following error provisioning a VM:

~~~bash
cp: cannot stat '<PATH>'$'\r': No such file or directory
cp: cannot stat '<PATH>'$'\r': No such file or directory
~~~

It is likely that you have a carriage return in your path. This can happen if you copy and paste a path from a Windows machine. To fix this, you can use the following command to remove the carriage return from the path:

```dos2unix <PATH>```

[//]: # (End of Path: errors\README.md)
