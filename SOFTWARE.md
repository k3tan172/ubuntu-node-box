----

#### [ [Introduction](README.md) ] -- [ [Hardware](HARDWARE.md) ] -- [ [Ubuntu](UBUNTU.md) ] -- [ [Software](SOFTWARE.md) ] -- [ [Credits](CREDITS.md) ]

-----
# An extensive guide to building your financial sovereignty on Ubuntu 18.04


[ [Bitcoin Core](#bitcoin-core) ] -- [ [btc-rpc-explorer](#btc-rpc-explorer) ] -- [ [Electrum Wallet](#electrum-wallet) ] --  [ [Electrum Personal Server](#electrum-personal-server) ] -- [ [Lightning Network](#lightning-network) ] -- [ [c-lightning](#c-lightning) ] -- [ [Spark Wallet](#spark-wallet) ]

## Software

### Bitcoin Core
#### [Install]

1.	Go to the [Bitcoin Core download page](https://bitcoin.org/en/download) using Mozilla Firefox. Firefox comes with the normal installation of Ubuntu. Great browser. Highly recommended. 
2.	Click on the Linux (tgz) 64 bit link. It will automatically be downloaded to ```/home/ketan/Downloads``` [Note that ketan would be your username]
3.	Open up Terminal and navigate to your Downloads directory. To do this, open terminal and type ```cd Downloads```
4.	Type ```ls``` and you should see the file that you just downloaded.
5.	Type ```sudo tar xzf bitcoin-0.18.0-x86_64-linux-gnu.tar.gz``` Type your password in. This will create a directory called ```bitcoin-0.18.0```. Type ```ls``` to confirm you can see the new directory.
6.	Type ```sudo install -m 0755 -o root -g root -t /usr/local/bin bitcoin-0.18.0/bin/*```

This successfully completes the installation of bitcoin core on to your machine. Congratulations, but we’re not done yet. We need to configure and run it.

But before we move on, I wanted to provide some commentary around why we've done what we've done and provide a bit of understanding on security in Ubuntu.

There are other ways to install bitcoin on Ubuntu that you'll find on the [Running A Full Node](https://bitcoin.org/en/full-node#ubuntu-1604) website as well as other guides found on the internet. Software packages in Ubuntu are typically found in what's known as Personal Package Archives (PPA). It makes the installation and update process much easier. In just a few terminal commands you can install and update the software you're interested in. The bitcoin website does however come with a disclaimer on this method. It states  "Note that you should prefer to use the official binaries, where possible, to limit trust in Launchpad/the PPA owner." The owner of the Bitcoin PPA is one of the developers. I'm sure he's trustworthy, but what if his computer is compromised and someone uploads a malicious version of bitcoin in to the PPA under his login credentials? If you typed in ```sudo apt-get upgrade``` and you'd be none the wiser. And that goes for anyone who maintains their software through the PPA, potentially corrupting thousands of nodes. 

That's not to say the method we've used to install bitcoin above is foolproof. It most definitely is not. What if, when we're downloading from the Bitcoin website, the website was compromised during that time? Someone has uploaded a shady version on the website? You will see on the [Running a Full Node](https://bitcoin.org/en/full-node#other-linux-distributions) website, there are 'optional' instructions on verifying the release signatures. Basically, it's an avenue by which you can determine that what you've downloaded is what the developers intended you to download. 

#### [Configure and run]

The plan is to start by configuring Bitcoin Core in Graphical User Interface (GUI), syncing the blockchain, and then we’ll move over to the Bitcoin Daemon, also known as Command Line Interface (CLI) from thereafter.
1.	In terminal, type in  ```/usr/local/bin/bitcoin-qt```
2.	Bitcoin core should start. You will be prompted to choose a directory. Make a mental note of the default directory, but DO NOT use it. Click on ‘Use a custom data directory’ instead. Click on the three dots and navigate to ```/mnt/2TBHDD/Bitcoin```
3.	Wait for the blockchain to download and synchronise. It’ll be a while.

Let’s take a break here and understand what we’ve done and where we’re going. The reason we started off in GUI is so you don’t freak out in the CLI when you see nothing happening. We also don’t want to start downloading the blockchain in the default directory ```/home/ketan/.bitcoin``` because the default directory is on the SSD, not the HDD. You will have noticed that there is a dot in front of the default bitcoin directory. In Linux, any folder with a dot in the front of the folder name are hidden folders that you won’t see when you browse through your files in the File Manager. 

There’s a bit of comfort in seeing the progress of the synchronisation in GUI mode. You can see you’re downloading it, it's progressing and you know it’s downloading to the right place. However, the end game is that we don’t want to be using GUI. We need to get comfortable with CLI use. 

<strong>Unfortunately, when we fire up the daemon, the blockchain will start downloading (again) to the default directory (the SSD where we do not want it) unless we tell it not to.</strong> So while we’re syncing up in GUI mode on the 2TBHDD, let’s set ourselves up for success in CLI mode. For users that are using the same drive as the one Ubuntu is installed on, you will not need to do this. But this is a common pitfall when you're using a drive that is NOT the one Ubuntu is installed on.  

4. The goal is to create a file in the default directory that Bitcoin CLI will read and tell it to find the blockchain data in the 2TBHDD. First we need to create the default directory. Let’s go to our home directory, make a .bitcoin directory and step into it.

    ```cd /home/ketan```
    
    ```mkdir .bitcoin```
    
    ```cd .bitcoin```

5. Now we need to create the file that Bitcoin CLI will look at and redirect it to the 2TBHDD.

    ```sudo nano bitcoin.conf```
    
    You will find yourself in a text editor. You’ll want to familiarise yourself with nano, a commonly used text editor within the terminal. What you’re about to do is create a file called ```bitcoin.conf``` within the ```/home/ketan/.bitcoin``` directory.
    In the text editor type

    ```datadir=/mnt/2TBHDD/Bitcoin```
    
    Hit CTRL+X to exit. At the bottom of the window it'll ask you if you want to save. Type Y and hit [ENTER] to save and exit.
    
    You have now created a file, the location of which is ```/home/ketan/.bitcoin/bitcoin.conf```
    
    It contains 1 line which is ```datadir=/mnt/2TBHDD/Bitcoin```

Now we just wait until the blockchain syncs in the GUI. Once it does

6.	Close down the Bitcoin Core GUI program.

7.	Here’s the command to fire up the bitcoin daemon (CLI)

    ```bitcoind -daemon```

    Wait a couple of minutes. It'll look as though nothing is happening. This is the magic of CLI - it happens in the background.

8.  Have a play around with it by typing the following commands and seeing what it spits out. 

    ```bitcoin-cli getconnectioncount```

    ```bitcoin-cli getnetworkinfo```

    ```bitcoin-cli getblockchaininfo```
    
    If you’re getting error: ```{"code":-28,"message":"Verifying blocks..."}``` it just means Bitcoin hasn’t finished its startup yet, wait a few minutes and try again.

    What you DON’T want is for the blockchain to start downloading again in the default directory ```/home/ketan/.bitcoin.```
    If you're seeing more files other than ```bitcoin.conf``` in your ```/home/ketan/.bitcoin``` directory, you've started downloading the blockchain again.

9.  To stop the daemon, type ```bitcoin-cli stop```
10. To start it up again, type ```bitcoind -daemon```

11. To fine tune your bitcoin node with further configuration options, edit the ```/home/ketan/.bitcoin/bitcoin.conf``` file by typing the following command into the terminal. Be sure to stop bitcoin before you edit the .conf file.

    ```sudo nano /home/ketan/.bitcoin/bitcoin.conf```

    You can configure and customise your node through commands identified on the bitcoin website [here](https://bitcoin.org/en/full-node#configuration-tuning). Jameson Lopp has built an intuitive way of configuring your bitcoin.conf file which can be found [here](https://jlopp.github.io/bitcoin-core-config-generator/).

12. One last thing we should do to help contribute to the bitcoin network is to open up our router port 8333 to allow incoming connections. More information can be found [here](https://bitcoin.org/en/full-node#network-configuration) on this. 

13. Confirm your node is accepting incoming connections by typing your IP address into [bitnodes.earn.com](http://bitnodes.earn.com) and it showing your bitcoin version. However, if you can't seem to get that to work, don't get too hung up on it. The goal is to get more than 8 connections when you type ```bitcoin-cli getconnectioncount``` into the terminal. Don't spent too much time on it. If you can get it, great. If you can't, try again later. Move on.

14. (Optional) You can also set up your node to run on TOR for an added level of privacy. Whilst outside the scope of this tutorial, Jameson Lopp has written up a guide which you can read [here](https://medium.com/@lopp/how-to-run-bitcoin-as-a-tor-hidden-service-on-ubuntu-cff52d543756) if you so wish. 

Congratulations, you’ve now set up, installed and run bitcoin on your computer. This forms the backbone of your personal financial infrastructure.

A final point, if you want to go back to using the GUI, you will have to stop the daemon. And if you want to use the daemon, you will have to stop the GUI. You can't use both at the same time.

#### [Run on startup]

Now we move on to getting the bitcoin daemon to run on startup every time your computer starts.

We are going to be configuring the machine to start software up sequentially. It'll start with bitcoin, then once bitcoin is up, btc-rpc-explorer, electrum-personal-server and lightningd will be started up, after which spark-wallet will be started. Each time you configure the autorun of a software, reboot your machine to test it works.  

The way Ubuntu handles application startups is through what’s known as the 'service manager'.

I’m going to describe the process for configuring the service manager. Try to understand it because almost every other piece of software we install, we’re going to do the same thing for.

1.	Stop the bitcoin daemon by typing in the terminal ```bitcoin-cli stop```
2.	Create what’s known as a service file

    ```sudo nano /etc/systemd/system/bitcoind.service```
    
3.	Open up Mozilla Firefox. Typically, you’ll find the .service file in GitHub Repositories in the ```contrib/init``` folder. Copy and paste the script from [here](https://github.com/bitcoin/bitcoin/blob/master/contrib/init/bitcoind.service) into the text editor and make the necessary amendments. You might find you can't use the paste shortcut (CTRL+V) in the text editor. Just right-click->paste into the terminal instead.

    Below is the copy and pasted script, however, I have edited it to suit our needs. Take note of the edits. Everything remains the same as what is on the GitHub file with the exception of the below.
    
    a) I've changed the ExecStart from ```/usr/bin``` to ```/usr/local/bin```
    
    b) I've changed the ```conf=```
    
    c) I've changed the ```datadir=```
    
    d) I've changed ```User=ketan```
    
    e) I've changed ```Group=ketan```
    
```    
# It is not recommended to modify this file in-place, because it will
# be overwritten during package upgrades. If you want to add further
# options or overwrite existing ones then use
# $ systemctl edit bitcoind.service
# See "man systemd.service" for details.

# Note that almost all daemon options could be specified in
# /etc/bitcoin/bitcoin.conf, except for those explicitly specified as arguments
# in ExecStart=

[Unit]
Description=Bitcoin daemon
After=network.target

[Service]
ExecStart=/usr/local/bin/bitcoind -daemon \
                            -pid=/run/bitcoind/bitcoind.pid \
                            -conf=/home/ketan/.bitcoin/bitcoin.conf \
                            -datadir=/mnt/2TBHDD/Bitcoin

# Process management
####################
Type=forking
PIDFile=/run/bitcoind/bitcoind.pid
Restart=on-failure

# Directory creation and permissions
####################################

# Run as bitcoin:bitcoin
User=ketan
Group=ketan

# /run/bitcoind
RuntimeDirectory=bitcoind
RuntimeDirectoryMode=0710

# /etc/bitcoin
ConfigurationDirectory=bitcoin
ConfigurationDirectoryMode=0710

# /var/lib/bitcoind
StateDirectory=bitcoind
StateDirectoryMode=0710

# Hardening measures
####################

# Provide a private /tmp and /var/tmp.
PrivateTmp=true

# Mount /usr, /boot/ and /etc read-only for the process.
ProtectSystem=full

# Disallow the process and all of its children to gain
# new privileges through execve().
NoNewPrivileges=true

# Use a new /dev namespace only populated with API pseudo devices
# such as /dev/null, /dev/zero and /dev/random.
PrivateDevices=true

# Deny the creation of writable and executable memory mappings.
MemoryDenyWriteExecute=true

[Install]
WantedBy=multi-user.target

```

CTRL+X, Y then ENTER to save and exit.

4.  Enter the following commands to enable the service, start the service and check the status of the service.

    ```sudo systemctl enable bitcoind.service```
    
    ```sudo systemctl start bitcoind.service```
    
    ```sudo systemctl status bitcoind.service```
    
    Hit CTRL+C to exit the service status
    
    This should get you up and running, but if you get any errors, something has gone wrong with the editing of the script file. You’ll need to go back, edit the ```bitcoind.service``` file and type 
    
    ```sudo systemctl daemon-reload```
    
    ```sudo systemctl start bitcoind```
    
    ```sudo systemctl status bitcoind```
    
    If successful, you should be able to run ```bitcoin-cli``` commands in your terminal such as ```bitcoin-cli getconnectioncount``` without any errors.

5.  The final step is to test if everything works as intended. The way we’ll do that is reboot the computer and see what happens.

    ```sudo reboot```
    
    Once the computer is back up again, open up terminal
    
    ```sudo systemctl status bitcoind```
    
    ```bitcoin-cli getconnectioncount```

    The service should be active and the command should work.

    Congratulations, you’ve now made bitcoin startup automatically on your computer. To stop, you can use either ```bitcoin-cli stop``` or ```sudo systemctl stop bitcoind```

#### [Update]

To update bitcoin core to the next available version, it is very similar to the installation procedures.
1.	Stop bitcoin by typing ```bitcoin-cli stop``` in terminal.
2.	Go to the Bitcoin Core download page using Mozilla Firefox. https://bitcoin.org/en/download
3.	Click on the Linux (tgz) 64 bit link. It will automatically be saved in ```/home/ketan/Downloads```
4.	Navigate to your Downloads directory. Type: ```cd /home/ketan/Downloads```
5.	Type ```ls``` and you should see the file that you just downloaded.
6.	Type ```sudo tar xzf bitcoin-0.18.1-x86_64-linux-gnu.tar.gz```. Type your password in. This will create a directory called ```bitcoin-0.18.1```. Type ```ls``` to confirm the new directory.
7.	Type ```sudo install -m 0755 -o root -g root -t /usr/local/bin bitcoin-0.18.1/bin/*```
8.	Type ```sudo systemctl restart bitcoind```
9.  Type ```bitcoin-cli --version```. This should display the version you've updated to.

You're now able to maintain your bitcoin node and update it when there's a new version out.

### btc-rpc-explorer

btc-rpc-explorer is a piece of software that hooks into your Bitcoin node and provides you with information and statistics about your node and the blockchain in a nice web browser interface. The GitHub repository can be found [here](https://github.com/janoside/btc-rpc-explorer) and a demo of what it looks like can be found [here]( https://btc.chaintools.io/)

Before we get into the installation, we need to prepare our system to ensure we don’t get any issues whilst we install. We need to add some more lines into our bitcoin.conf file and install some packages. So let's get cracking with the .conf file.

```sudo systemctl stop bitcoind```

```sudo nano /home/ketan/.bitcoin/bitcoin.conf```

Add the following lines to your existing configuration.

```
txindex=1
server=1
```

Save and close nano by CTRL+X, Y then [ENTER]
```sudo systemctl start bitcoind```

Now let’s get into installing some packages

```sudo apt-get update```

```sudo apt-get install git```

```sudo apt-get install curl```

We now need to install node.js using what’s known as a ‘node version manager’ or nvm. I used the below command found in the nvm GitHub repository [here](https://github.com/creationix/nvm)

```curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash```

Close your terminal and reopen it up. To verify it’s been installed, type:

```command –v nvm```

It should show ```nvm``` as output.

To install node.js

```nvm install node```

You should now be able to type ```npm``` in the terminal. The reason we use the node version manager is to avoid permission errors. You can read more information about this [here]( https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally).

So let’s get back to our primary goal of installing btc-rpc-explorer

#### [Installation]

Installation is pretty simple. Fire up in terminal:

```npm install –g btc-rpc-explorer```

If you see permission errors or other errors in RED text, that's not a good sign, but if you see WARNING errors in yellow, it's fine. I've provided a link above where you can do more reading if you're seeing a bloodbath of red. The nvm GitHub repository is another avenue for information.

#### [Run and configure]

Running btc-rpc-explorer is again pretty simple. Just make sure your bitcoind is running.

```btc-rpc-explorer --bitcoind-cookie /mnt/2TBHDD/Bitcoin/.cookie```

Check that this works by opening up Firefox and going to http://localhost:3002. You should see a nice web page interface.

Go back to the terminal and hit CTRL+C to stop running btc-rpc-explorer service.

Let’s now make a configuration file that btc-rpc-explorer just reads and executes.

```sudo nano /home/ketan/.config/btc-rpc-explorer.env```

There are plenty of configuration options that are documented in the official repository, which you can find [here](https://github.com/janoside/btc-rpc-explorer/blob/master/.env-sample)

I have only got these two lines in my ```btc-rpc-explorer.env``` file

```
BTCEXP_BITCOIND_COOKIE=/mnt/2TBHDD/Bitcoin/.cookie
BTCEXP_HOST=0.0.0.0
```

The first line is the link between the bitcoin node and btc-rpc-explorer. It is the file that allows btc-rpc-explorer to access your node.

The second line allows you to access http://localhost:3002 through any computer on your network. You can reach it through your internal IP address. My internal IP address is http://192.168.1.49:3002 for example.

Now all you need to do is run ```btc-rpc-explorer``` and you should be good to go. Note that btc-rpc-explorer won’t work unless you have bitcoind running. If you getting it running through the terminal, the problem is that it’ll hog up the terminal which you can’t close without shutting down btc-rpc-explorer.

That’s where the Ubuntu service manager comes to our rescue, again. Let's get into it.

#### [Run on startup]

As we learnt when we launched bitcoin on startup, we need to create a .service file and edit it to our requirements. Note the edits I have made below. If you don’t know what the ExecStart directory should be, open up another terminal and type ```whereis btc-rpc-explorer```. That will give you the full path. Mine is /home/ketan/.nvm/versions/node/v11.11.0/bin/btc-rpc-explorer. So you’ll see that reflected in my ExecStart in the script below. I’ve also edited the environment file location and the User and Group.

```sudo nano /etc/system/system/btc-rpc-explorer.service```

Copy and paste this script in and edit to your requirements.

```
[Unit]
Description=btc-rpc-explorer
After=bitcoind.service
Requires=bitcoind.service


[Service]
EnvironmentFile=/home/ketan/.config/btc-rpc-explorer.conf
ExecStart=/home/ketan/.nvm/versions/node/v11.11.0/bin/btc-rpc-explorer

RuntimeDirectory=btc-rpc-explorer
PIDFile=/run/btc-rpc-explorer/explorer.pid
User=ketan
Group=ketan

Type=simple
KillMode=process
Restart=on-failure
RestartSec=60

# Hardening measures
####################

# Provide a private /tmp and /var/tmp.
PrivateTmp=true

# Mount /usr, /boot/ and /etc read-only for the process.
ProtectSystem=full

# Disallow the process and all of its children to gain
# new privileges through execve().
NoNewPrivileges=true

# Use a new /dev namespace only populated with API pseudo devices
# such as /dev/null, /dev/zero and /dev/random.
PrivateDevices=true

[Install]
WantedBy=bitcoind.service
```

CTRL+X, Y then ENTER to save and exit.
Like we did for the bitcoind.service file, we’ll do the same for btc-rpc-explorer.service file

```
sudo systemctl enable btc-rpc-explorer
sudo systemctl start btc-rpc-explorer
sudo systemctl status btc-rpc-explorer
```

CTRL+C to exit the service status

If you’ve done something wrong with your .service file, try again. Keep trying until you get it active and green. Remember to ```sudo systemctl daemon-reload``` each time you edit the file.

Starting to get the hang of it? Good.

#### [Update]

To update btc-rpc-explorer we need to stop the daemon, install again, then start the daemon back up again.

```
sudo systemctl stop btc-rpc-explorer
npm install -g btc-rpc-explorer
sudo systemctl start btc-rpc-explorer
```

### Electrum Wallet

The wallet found in the Bitcoin GUI application itself is quite basic. Installing Electrum Bitcoin Wallet gives you access to enhanced features and also allows you to connect your hardware wallet. Later on, we’ll install electrum-personal-server which hooks into your bitcoin node and into your electrum wallet so you can send and receive transactions using your very own node, not the public ones provided by Electrum. But for now, let's just install the wallet.

Important note, whilst Electrum Bitcoin Wallet is safe to use, it is imperative that you download it from the right source. Do not use any source other than the official website: [https://www.electrum.org](https://www.electrum.org).

#### [Installation]

The instructions to install the software are listed on the download section of the Electrum website. But let’s go through the steps anyway.

1.	 Open up Firefox and download the Electrum tar.gz file under ‘sources’ off the [Electrum website](https://electrum.org/#download)
2.	Install the following software packages

    ```sudo apt-get install python3-pyqt5 python3-setuptools python3-pip```

If it asks for your password, enter it.
Type Y to confirm the packages to be installed then hit [ENTER] 

3.	Navigate in terminal to where you downloaded the tar.gz file

    ```cd /home/ketan/Downloads```

4.	Install the package. Ensure you use the correct filename. Currently it is version 3.3.8.

    ```python3 -m pip install --user Electrum-3.3.8.tar.gz[fast]```

#### [Run and configure]

To run electrum is straight forward. In terminal just type

```electrum```

If that doesn’t work, try

```/usr/local/bin/electrum```

If that doesn’t work, try

```/home/ketan/.local/bin/electrum```

If that doesn’t work, try

```whereis electrum```

If that shows nothing, reboot and try again. If you’re successful in opening electrum we’ll configure the wallet for now.

Auto-connect. Next.

Name your wallet, or leave as default_wallet. Next.

Standard wallet is the type of wallet you want to create. Run your eye over all the options. Next.

Create a new seed. Run your eye over all the options. Next.

Segwit. Next.

Write down the 12 words on paper in order. Keep these 12 words safe if you intend to use this wallet. In the next screen, the software makes you type the 12 words in, just to make sure you’ve got it. Next.

Confirm your seed by typing it in. Next.

Put a password if you want. Be sure to remember it. Next.

Click yes to being notified of updates to Electrum.

Welcome to your new wallet.

Have a browse around. Once you’re done, shut it down. We've got more to do.

The electrum wallet is software that we do not wish to launch on startup. It’s an application that we want to appear in the Ubuntu Application Launcher. It’s a wallet we use when we need it, like an app on your phone. To get the ‘Electrum Bitcoin Wallet’ in the Application Launcher, we need to configure what is known as an ```electrum.desktop``` file. 

We are going to get the electrum.desktop file off the GitHub repository. Keep a mental note of this file because we are going to modify it when we install electrum-personal-server.

Open up a terminal and navigate to your Downloads folder

```cd /home/ketan/Downloads```

Download the file

```wget https://raw.githubusercontent.com/spesmilo/electrum/master/electrum.desktop```

We’re also going to get the Electrum Bitcoin Wallet icon off the GitHub repository as well and place it into a particular system folder for ```electrum.desktop``` to read.

```sudo wget -P /usr/share/pixmaps/ https://raw.githubusercontent.com/spesmilo/electrum/master/electrum/gui/icons/electrum.png```

Now we’re going to execute the electrum.desktop file.

```sudo desktop-file-install electrum.desktop```

You should now see a new icon in the application launcher with a nice Electrum logo. Click on it to test that it works. You can also add it to your favourites sidebar by right-clicking on it and adding to favourites. 

#### [Run on startup]

Electrum Bitcoin Wallet should not be run on startup. This is software used as required.

#### [Update]

Updating Electrum is similar to the procedures described in the installation.

Open up Firefox and download the latest tar.gz file from the downloads page of electrum.org

```cd /home/ketan/Downloads```

``` python3 -m pip install --user Electrum-3.3.9.tar.gz[fast]```

Go to your application launcher and launch Electrum. Version should be updated to the latest. You can check through Help >>> About.

### Electrum Personal Server

Electrum Personal Server is the bridge between your own bitcoin node and your electrum wallet. Instead of using electrum servers (which can be compromised), the electrum wallet will use your own node to broadcast transactions.

The GitHub repository can be found [here](https://github.com/chris-belcher/electrum-personal-server). This is probably one of the better documented github repositories I’ve seen, but I’ll take you through what’s going on.

#### [Installation]

Let’s go to our home directory

```cd /home/ketan```

Download a copy of the repository into our home directory

```git clone https://github.com/chris-belcher/electrum-personal-server.git```

Step into the newly created folder

```cd electrum-personal-server```

Install the server

```pip3 install .```

#### [Configure and run]

Make sure you’re install in the electrum-personal-server folder

```cd /home/ketan/electrum-personal-server```

Copy the sample configuration file and rename it to the filename EPS will recognise and read

```cp config.ini_sample config.ini```

Edit the config.ini file using nano text editor

```sudo nano config.ini```

We now need to make some edits to the config.cfg file so that it works

Firstly, we need to open up Electrum Bitcoin Wallet and go to Wallet > Information. There we will see the zpub/xpub string of characters. 

Under the ```[master-public-keys]``` section of the config.ini file, you will already see a ```#any_name_works = xp….``` line.

Whenever there is a # infront of a line, it means it’s a comment and is inactive. If you remove the # in the line item, this turns into a line item that is active. So go ahead and remove the # before ```#any_name_works = xpub………..``` line. Also replace the xpub string of characters with your wallet’s string of characters.

We also need to make sure the ```datadir``` is set. Scroll down and set the ```datadir``` to ```datadir = /mnt/2TBHDD/Bitcoin```

CTRL+X then Y and [ENTER] to save and exit.

Close Electrum Bitcoin Wallet.

We’re done configuring electrum personal server, so let’s run it.

```electrum-personal-server /home/ketan/electrum-personal-server/config.ini```

Now that we’ve got electrum-personal-server running, it would be a good time to configure the Electrum Bitcoin Wallet to only use our bitcoin node exclusively to broadcast transactions.

Remember that electrum.desktop file we were editing when we were installing electrum bitcoin wallet? Let’s go back to it

```cd /home/ketan```

```sudo nano /home/ketan/electrum.desktop```

See the line that says

```Exec=sh -c "PATH=\"\\$HOME/.local/bin:\\$PATH\"; electrum %u"```

It needs to be changed to

```Exec=sh -c "PATH=\"\\$HOME/.local/bin:\\$PATH\"; electrum --oneserver --server localhost:50002:s %u"```

CTRL+X, then Y and [ENTER] to save and exit.

```sudo desktop-file-install electrum.desktop```

Open up Electrum Wallet from the app launcher or favourites sidebar.

In the bottom right of the application there should be a green status circle. Click on it and confirm you’re connected to 1 node and it’s localhost*.

If you run into an issue whereby your balances aren't updating on your Electrum Wallet, the likely issue is that you have not put in the z/xpub of your wallet into your ```config.ini``` file. If you are adding new z/xpubs into your ```config.ini``` be sure to run ```electrum-personal-server --rescan /home/ketan/electrum-personal-server/config.ini``` 

#### [Run at startup]

To run electrum-personal-server at start up, we need to create the .service file.

```sudo nano /etc/systemd/system/eps.service```

Paste the following into the text editor and make the necessary amendments. We're amending the ExecStart line, User and Group.

```
[Unit]
Description=Electrum Personal Server
After=bitcoind.service
Requires=bitcoind.service

[Service]
ExecStart=/home/ketan/.local/bin/electrum-personal-server /home/ketan/electrum-personal-server/config.cfg

RuntimeDirectory=eps
PIDFile=/run/eps/eps.pid
User=ketan
Group=ketan

Type=simple
KillMode=process
Restart=on-failure
RestartSec=60

# Hardening measures
####################

# Provide a private /tmp and /var/tmp.
PrivateTmp=true

# Mount /usr, /boot/ and /etc read-only for the process.
ProtectSystem=full

# Disallow the process and all of its children to gain
# new privileges through execve().
NoNewPrivileges=true

# Use a new /dev namespace only populated with API pseudo devices
# such as /dev/null, /dev/zero and /dev/random.
PrivateDevices=true

# Deny the creation of writable and executable memory mappings.
MemoryDenyWriteExecute=true

[Install]
WantedBy=bitcoind.service
```
CTRL+X then Y and [ENTER] to exit and save.

Let's enable, start and check the status of electrum-personal-server on start up.

```sudo systemctl enable eps```

```sudo systemctl start eps```

```sudo systemctl status eps```

CTRL+C to close the status.


#### [Update]

Stop electrum-personal-server

```sudo systemctl stop eps```

In terminal, go into the directory you downloaded electrum personal server.

```cd /home/ketan/electrum-personal-server```

Update from the GitHub Repository

```git pull```

Confirm the new version you want

```git pull origin master```

```pip3 install .```

Start the service back up again

```sudo systemctl start eps```

### Lightning network

The Bitcoin Lightning Network sits on top of your bitcoin node and enables quick transactions and low fees. It requires users to lock in a channel (by an on-chain bitcoin transaction) with other peers on the network.
There are a few implementations of the lightning network. The most common are c-lightning (developed by Blockstream), LND (developed by LightningLabs) and éclair (developed by ACINQ).It shouldn’t matter which implementation you use, as they are developed to the ‘Basis of Lightning Technology’ (BOLT) specifications.

With my node, I have used c-lightning, as I found it easy to install. We will go down the path of installing that. Later on, we’ll install spark-wallet, which is a nice graphical way to interact with our c-lightning node.

Disclaimer: The Lightning Network is still in development stage. The tutorial below will set you up on mainnet, which means you’re working with real funds. This is not yet recommended by developers. I would suggest you only put onto your lightning network node as much as you’re willing to lose. Think of it as a cost of experimentation. For me, that amount was $50USD. 
As of now, there is no great solution to backing up your lightning network node. If you encounter a hard drive failure, you might not be able to recover your funds. This is where the loss of funds can potentially arise.

### c-lightning

The GitHub repository can be found [here](https://github.com/ElementsProject/lightning)

#### [Installation]
To install c-lightning the following commands should be made in terminal.

Choose the directory to download the repository to. I used ```/home/ketan```

```sudo apt-get update```

```sudo apt-get install autoconf automake build-essential git libtool libgmp-dev libsqlite3-dev python python3 net-toolszlib1g-dev libsodium-dev```

Hit Y then [ENTER] to download these packages and install.

```git clone https://github.com/ElementsProject/lightning.git```

```cd lightning```

```make```

```make install```

#### [Run and configure]

First let’s confirm your installation worked. Does a .lightning folder exist in your /home/ketan folder? To do check this

```cd /home/ketan```

```ls –a```

You should be able to a .lightning folder. If not, go back and try again.

We now need to create a configuration file in this folder.

```sudo nano /home/ketan/.lightning/config```

The text editor will open up. Let’s type a few lines in.

```
alias=WHATEVERYOUWANT # This is the public name of your node. Mine is called LIGHTNINGLORD.
network=bitcoin  # This puts us on the main net. 
bind-addr=192.168.1.49:9735 # Put in your internal IP address
announce-addr=XXX.XXX.XXX.XXX:9735 # Put in your external IP address.

```

There are plenty more configuration options you can do later, but for now, let’s just get to a state whereby you can open channels with others and others can open channels with you.

You’ll need to open up port 9735 on your router, just as you did with port 8333 for Bitcoin. If you don’t do this, your node will not be accessible for incoming connections.

Let’s now start up c-lightning. Make sure your bitcoin node is up and running. Now let’s type:

```lightningd``` 

Hopefully the lightning node should start up with no errors.

Hit CTRL+C to exit 

To start it up as a daemon, the command is

```lightningd --daemon```

Check that it works by typing into the terminal

```lightning-cli getinfo```

To stop the daemon

```lightning-cli stop```

If you find on running lightningd you get an issue regarding wallet blockchain hash not matching network blockchain hash, delete the ```lightningd.sqlite3``` file in the ```/home/ketan/.lightning``` folder and run again.

```rm -rf /home/ketan/.lightning/lightningd.sqlite3```

#### [Run on startup]

To run this program on startup, we need to produce our trusty .service file.

```sudo nano /etc/systemd/system/lightningd.service```

Copy and paste the script found [here](https://github.com/ElementsProject/lightning/blob/master/contrib/init/lightningd.service) into the terminal.
We need to make edits as always. I've edited the script to reflect my circumstances below. I have edited the ExecStart, User and Group lines.

```
# It is not recommended to modify this file in-place, because it will
# be overwritten during package upgrades. If you want to add further
# options or overwrite existing ones then use
# $ systemctl edit lightningd.service
# See "man systemd.service" for details.

# Note that almost all daemon options could be specified in
# /etc/lightningd/lightningd.conf

[Unit]
Description=C-Lightning daemon
Requires=bitcoind.service
After=bitcoind.service

[Service]
ExecStart=/usr/bin/lightningd --daemon --conf /home/ketan/.lightning/config --pid-file=/run/lightningd/lightningd.pid

# Creates /run/lightningd owned by bitcoin
RuntimeDirectory=lightningd

User=ketan
Group=ketan
Type=forking
PIDFile=/run/lightningd/lightningd.pid
Restart=on-failure

# Hardening measures
####################

# Provide a private /tmp and /var/tmp.
PrivateTmp=true

# Mount /usr, /boot/ and /etc read-only for the process.
ProtectSystem=full

# Disallow the process and all of its children to gain
# new privileges through execve().
NoNewPrivileges=true

# Use a new /dev namespace only populated with API pseudo devices
# such as /dev/null, /dev/zero and /dev/random.
PrivateDevices=true

# Deny the creation of writable and executable memory mappings.
MemoryDenyWriteExecute=true

[Install]
WantedBy=multi-user.target
```
CTRL+X, Y then [ENTER] to save and exit the text editor. Now enable, start and check the status.

```sudo systemctl enable lightningd.service```

```sudo systemctl start lightningd.service```

```sudo systemctl status lightningd.service```

CTRL+C to exit status mode.

You can check that it works correctly by typing a lightning command such as 

```lightning-cli getinfo```

#### [Update]

Since we used git to download c-lightning, we're going to need to go to the directory we downloaded it, update, and reinstall it.

```sudo systemctl stop lightningd```

```cd /home/ketan/lightning```

```git pull origin master```

```make```

```make install```

```sudo systemctl start lightningd```

Check that the version has been updated

```lightning-cli --version```

### Spark Wallet

Spark wallet allows you to connect to your c-lightning node in a graphical way so that you do not need to enter in commands into the terminal. It's meant to be a user-friendly way to interact with your lightning node. It even has an android app. The GitHub repository can be found [here](https://github.com/shesek/spark-wallet). Keep in mind there are two distinct pieces of software we're setting up here. The first is the spark-wallet server and the second is the spark-wallet client. The client connects to the server.

#### [Installation]

Installing spark-wallet server is fairly straight forward. 

```npm install -g spark-wallet```

If you see a heap of permission errors, ensure that you have read the notes [here](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally).

#### [Configure and run]

We need to create the configuration file for spark-wallet.

```sudo nano /home/ketan/.spark-wallet/config```

In this config file we're going to have the following lines in there. Edit where required.

```
ln-path=/home/ketan/.lightning/
login=ketan:password
no-tls=1
host=0.0.0.0
```
CTRL+X, then Y and [ENTER] to save and exit.

To run spark-wallet server, it's fairly straight forward. Type the following into terminal.

```spark-wallet -P```

Check if it works by opening up Firefox and heading to http://localhost:9737 and http://192.168.1.49:9737.

The ```-P``` in the command should print out the pairing-url that you can use to pair your spark wallet client with. Download the various spark-wallet clients from [here](https://github.com/shesek/spark-wallet/releases). You'll find there's clients for MacOS, Android, Windows etc. If you pair the client with the server, you can use your spark-wallet from other devices.

CTRL+C to close spark-wallet server down.

#### [Run on startup]

To run on startup, again, we're going to create a .service file.

```sudo nano /etc/systemd/system/spark-wallet.service```

Copy and paste the service script from [here](https://github.com/shesek/spark-wallet/blob/master/scripts/spark-wallet.service) into the text editor and make the necessary edits. This time it appears that ExecStart=, the User= and Group= needs changing. To get the ExecStart line, you can type ```whereis spark-wallet``` into your terminal.

```
[Unit]
Description=Spark Lightning Wallet
Requires=lightningd.service
After=lightningd.service

[Service]
User=ketan
Group=ketan
Restart=on-failure

ExecStart=/usr/bin/spark-wallet

SyslogIdentifier=spark-wallet
PIDFile=/var/run/spark-wallet.pid
StandardInput=null
StandardOutput=syslog
StandardError=syslog

# Hardening measures
PrivateTmp=true
ProtectSystem=full
NoNewPrivileges=true
PrivateDevices=true

[Install]
WantedBy=multi-user.target
```

CTRL+X, Y and [ENTER] to save and exit.

We now need to enable, start and check the status of spark-wallet.

```
sudo systemctl enable spark-wallet
sudo systemctl start spark-wallet
sudo systemctl status spark-wallet
```

If you're green and active, you're good. CTRL+C to exit the status.

Check that you can access http://localhost:9737
Use the login username and password you set in the config file to gain access.

#### [Update]

We can update spark-wallet by

```
sudo systemctl stop spark-wallet
npm install -g spark-wallet
sudo systemctl start spark-wallet
```

#### [Usage of Spark]

*** Warning: Lightning network is experimental software. Use at your own risk. ***

You can now use spark-wallet to command your lightning node. Here are a couple of steps to get you going.

1. Fund your lightning node 

   In the spark-wallet client interface, click on 'node: ' down the very bottom. Click on Deposit. You must now send onchain bitcoins to this address to 'fund' your lightning node. Only put on what you're willing to lose. For me that was $50USD. Wait until the transaction confirms.
   
2. Set up a channel

    Click on 'node:' again and then 'Channels'. Click on 'Open channel'. If you'd like to open up a channel with any of the nodes on 1ml.com. Enter an amount (I generally work in sats), so say 200,000 sats, and click 'Open Channel'. This essentially locks in an on-chain transaction with the node. Wait until it shows 'active' in your channels listing.
    
If you want your node to appear on 1ML.com, open up a channel with them.

3. Pay someone

    You can ask a friend to send you an invoice to pay. You can go to the blockstream store https://store.blockstream.com/ and buy some stickers. There are more stickers at bitcoinstickerpack.com. You can pay for some articles that interest you on http://www.yalls.org. You can try your luck at http://www.lightning-roulette.com. There's a website dedicated to lightning network spending at https://lightningnetworkstores.com. Go nuts.

4. Find incoming channel partners

    To receive money, you need to have incoming channels (i.e, other lightning nodes connecting to your node). You can find your node address to give to others when you click on "node: " down the bottom of spark-wallet. Keep in mind to accept incoming connections, you will have to open up port 9735 on your router. You can go to http://lightningto.me to receive some incoming capacity by jumping through their hoops. At this point in time, c-lightning does not allow you to have two way channels. This means that if you have an outgoing channel open with me, I can't open an incoming channel with you. The developers are working on incorporating this feature in for the next release.


