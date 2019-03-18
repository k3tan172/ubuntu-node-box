----
#### [ [Introduction](README.md) ] -- [ [Hardware](HARDWARE.md) ] -- [ [Ubuntu](UBUNTU.md) ] -- [ [Software](SOFTWARE.md) ] -- [ [Credits](CREDITS.md) ]

-----
# An extensive guide to building your financial sovereignty on Ubuntu 18.04

## Hardware

The below outlines the hardware I'm using for my node.

I bought an office refurbished Dell Optiplex 9020. It has an Intel i7-4770 CPU with 8GB of RAM. This cost me $300AUD off eBay which I found on [OzBargain](http://www.ozbargain.com.au). I put in a spare 512GB Solid State Drive (SSD) that I had lying around to install Ubuntu on. I also had a spare internal 2TB Hard Disk Drive (HDD) to store the blockchain on. It kind of goes without saying, but it also has a network card and a power supply. You’ll probably want a keyboard/mouse/monitor as well. However, I’ve set my machine up for remote access, so I just use my laptop to control the computer. No keyboard, mouse or monitor required.

A computer with these kinds of specs can easily take on this project. It's relatively inexpensive and great for learning. Try to get something similar. Before you buy anything, do your research and make a plan. Consider using hardware that you already have such as laptops, hard drives and old desktops. The recommended hardware requirements of Ubuntu are listed [here](https://help.ubuntu.com/community/Installation/SystemRequirements). 

The other point I’d like to make regarding hardware is that there are a lot of tutorials online to set up a node using a Raspberry Pi. Whilst RPi’s are great devices that will teach you a lot, they just do not have the grunt to handle what we’re about to embark upon. I don't want to undermine the incredible work that goes into creating Bitcoin related Raspberry Pi projects and guides, but I think it allows very litte overhead for mistakes to be made. It also may not allow other projects to be installed. You may get a poor experience and will be put-off by the entire process. And that’s the last thing you want when dealing with a project as exciting as this.

Since we will be downloading the entire blockchain, I would recommend a smaller SSD to install Ubuntu on (operating systems tend to run faster on an SSD), and a HDD to download the entire blockchain onto. The HDD can be internal or external. I have an internal drive. I would recommend you pay for quality on the hard drives you use. We are building you a system that will be running 24/7 for a long time coming.

One of the great things about bitcoin is that not only can you reliably estimate the supply of bitcoin in circulation at any point in time, you can also reliably estimate how much hard drive space you’re going to need. As it stands in March 2019, we’re at around 240GB. Bitcoin started in January 2009. Ten years of bitcoin gave us 240GB. It grows at a rate of approximately 1MB per 10 minutes. So in 2029? We’re looking at max 500GB. Probably less with efficiencies gained over time. 2TB may seem a bit overkill, so you may wish to go with 1TB or 500GB. However, in my experience, as you play around with your Ubuntu desktop, you’ll find other uses for it such as Blockstream Satellite, HoneyMiner, hosting a media server, a torrent box or other software you find on GitHub. If you've got decent hardware specs, you can use a virtual machine as a test environment and when you're ready, deploy it onto your production environment. In short, better hardware gives more opportunities to explore this space.

Ok enough on hardware, let’s get cracking.
