Camp Setup
========
rake camp:rebuild RAILS_ENV=development


SFTP / Proftpd setup and use
========
In development, proftpd is run on a camp-specific port number and uses virtual users, but
you'll need to update your camp's var/proftpd.conf file to match your camp's paths, database
connection info, as well as the proftpd port number in order for it to run correctly in
*your* camp. See below for how to start and access it.

To run proftpd in production, just take the camp-specific var/proftpd.conf file from this
git repo and either customize all the camp-specific config entries, or delete them and
let proftpd run with the defaults. You will need to keep and customize the following 
config values: SQLConnectInfo, SQLDefaultUID, SQLDefaultGID. See the camp-specific
proftpd.conf for more details.

To start proftpd in a camp, do this as *root*:

  proftpd -c /home/phunk/camp12/var/proftpd.conf

To restart proftpd in a camp, do this as *root*:

  kill -HUP `cat /home/phunk/camp12/var/run/proftpd.pid`

To connect and upload files:

  sftp -oPort=10120 $username@174.37.104.41

where the port is correct for your camp, and $username is from the SFTP piece of
the Upload UI.
