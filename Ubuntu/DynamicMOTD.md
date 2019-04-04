If you have an Ubuntu server that does not display the package update info, similar to this:

```
0 packages can be updated.
0 updates are security updates.
```

Then here's how to get it running

```
sudo apt-get install -y lsb-release figlet update-motd
sudo vi /etc/ssh/sshd_config
	UsePAM yes
sudo service ssh restart
```

Found the much more detailed instructions from here https://oitibs.com/ubuntu-16-04-dynamic-motd/
