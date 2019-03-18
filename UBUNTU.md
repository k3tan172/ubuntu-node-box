----

#### [ [Introduction](README.md) ] -- [ [Hardware](HARDWARE.md) ] -- [ [Ubuntu](UBUNTU.md) ] -- [ [Software](SOFTWARE.md) ] -- [ [Credits](CREDITS.md) ]

-----
# An extensive guide to building your financial sovereignty on Ubuntu 18.04

## Ubuntu Installation

Once you’ve got your hardware going, it’s time to install Ubuntu on it. There are plenty of tutorials on the internet on how to create a USB boot disk for Ubuntu 18.04LTS and installing it onto your computer. Read the below points as you go through the installation process.

1.	Install the operating system on an SSD if possible. The system will run much faster on an SSD.
2.	‘Normal installation’ is fine. No need for minimal installation. We've got the hardware for it.
3.	When picking yourself a username and password, keep the password secure, but username simple. You’re going to be typing it in a fair bit. My name is Ketan, so my username is ketan. My ‘home’ directory will therefore be ```/home/ketan```. Sometimes, this is abbreviated to just ```~/```.
4.	When setting a computer name, keep it simple as well. Maybe ‘node’ or ‘box’. No need to get fancy. But it is up to you.
5.	Choose to login automatically at startup.

Once you’re in Ubuntu, a couple of further points to set you in the right direction
1.	Find the internal IP address of your machine. Mine is ```192.168.1.49```. To find this information, click on Show Applications (it's the 9 dots on the bottom left) > Settings > Network > Settings Cog Wheel of your active ethernet/wireless connection. Make note of this internal IP address on your network. We'll need it later.
2.	You might find when you plug in your HDD, nothing happens or you can't find it in the File Manager. What gives? It’s there, it’s just not ‘mounted’. Ubuntu sometimes does not automatically mount external or internal hard drives, so we need to configure that. To do this, make sure the drive is connected to your computer. 

    Click on Activities. In the search bar, type ‘Disks’ and click on the program. 
    
    On the side you’ll see a list of all your drives. They should all be there.
    
    Click on the one that you’ll be using to download the blockchain onto. 

    Click on the ‘cog wheel’ then Edit Mount Options.

    Turn 'User Session Defaults' to OFF. Check 'Mount at system startup' and 'Show in user interface'.
    
    Go down to Identify As and use LABEL. The mount point should be ```/mnt/LABELNAME```. Click OK. 

    Click on the Play button to mount the drive. 

    If you get errors, or if it’s a brand new drive, or it just doesn't work, format the drive as an EXT4 filesystem. This can be done in the 'Disks' program you're already in. Label it something straightforward. ‘2TBHDD’ will suffice. I recommend formatting the hard drive completely and starting from a blank drive. This will help minimise permission errors.  Warning - formatting a drive erases the entire contents of the drive, so back up the existing data before formatting it.
    
    Ultimately, the goal is to have Ubuntu mount the drive automatically on startup. The location of where to access the drive should be ```/mnt/2TBHDD```.
3.	We now need to create a Bitcoin folder in the mounted 2TBHDD. On your desktop you should see a drive called 2TBHDD. Double click on it. Create an empty folder called Bitcoin. The directory we will store the blockchain on will be ```/mnt/2TBHDD/Bitcoin```. This is an important directory and we’re going to need that for later.
4.	We are also going to need to have the latest software packages installed. Go to Show Applications > Terminal. Before you click on Terminal, you may wish to right-click on Terminal and ‘Add to favourites’ so it appears on your sidebar. You’ll be using it a lot, so get familiar with it.

    In the terminal window, type

    ```sudo apt-get update``` 

    Type in your password then hit [ENTER]. Watch it do its thing. Then type

    ```sudo apt-get upgrade``` 

    Type ‘y’ then hit [ENTER] if required and watch it do its thing.

It's now worthwhile rebooting your computer to ensure the hard drive is mounted automatically on startup.

```sudo reboot```

At this point, we’ve prepared our Ubuntu machine to start the installation of our key financial infrastructure software, so let’s start with the backbone – Bitcoin.
