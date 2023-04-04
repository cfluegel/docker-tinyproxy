# docker-tinyproxy

[Tinyproxy](https://tinyproxy.github.io/) is a lightweight HTTP and HTTPS proxy software. Caching is no longer a useful feature because of 
wide spread use of HTTPS, but a proxy can still improve the performance of a connection. 

There are docker container images for tinyproxy available, but because it is so lightweight I grabbed the opportunity and experimented 
with docker a bit more. 

I wanted to achieve the following goals: 

[x] learn how to use multi-stage docker builds 
[x] how I can change the behaviour with environment variables (-e) 
[x] generate a tinyproxy image that I can use for myself 

**Warning** I dont recommend anyone to use this repo or the image. Even thought it will work and will get improved over time, 
this is still just an learning project. There are other docker images for tinyproxy that probably made by people who know 
what they are doing :) 


