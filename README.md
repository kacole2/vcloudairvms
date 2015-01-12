## vCloud Air VMs

This application is a demonstration of using Rails to talk to the vCloud Air API. This application does a few things:
1. Creates a new instance for connecting to vCloud Air
⋅⋅* This instance is random based on UUID. It will be very very hard to replicate or steal someone information
2. Once Logged in, you can choose VDCs and vApps to see your VMs in a list
⋅⋅* This process is all done with AJAX back to a rails controller. I'll probably book mark that for later
3. Once done, click on Destroy to kill your session

Access it at [http://vcloudairvms.cfapps.io](http://vcloudairvms.cfapps.io)

![Screenshot](https://github.com/kacole2/vcloudairvms/blob/master/app/assets/images/ss.png "Screenshot")