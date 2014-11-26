# Installation Docs

### Production Software Used

- Ubuntu 14.04.1 LTS

- Thin app server

- Nginx web server

- Solr key-value store search platform

- PostgresQL DBMS

- Ruby 2.1.2

- Rails 3.2.19




### General Steps to deploy

- Setup Ubuntu

- Install Ruby 2.1.2

- Setup Nginx

- Setup PostgresQL
 
 - Setup [Solr](http://lucene.apache.org/solr/) on [Tomcat](http://tomcat.apache.org/) to be used with the [Sunspot](http://sunspot.github.io/) gem.

### Setup Instructions

##### Not sure where code will live but pull from a repo first.

##### 1.
Use [this guide](https://gorails.com/deploy/ubuntu/14.04) to automate deployment of some of the software listed above with [capistrano](http://capistranorb.com/).  This app uses ruby 2.1.2, so keep that in mind when the guide prompts you to install the latest ruby.  Follow that guide until the Final Steps, ignoring all the steps to setup or install passenger.   We'll also get to nginx config later.  Afterwords, we'll need to

     $ gem install bundler
     
     $ sudo apt-get install nodejs
     
(nodejs is for our javascript runtime)


##### 2.

Now we need to install an rbenv plugin that will allow us to use gems inside a sudo environment, as thin needs root to run.

Make sure you are still logged in as the deploy user

    $ mkdir -p ~/.rbenv/pluggins
    
then
    
    $ git clone git://github.com/dcarley/rbenv-sudo.git ~/.rbenv/plugins/rbenv-sudo
    
install thin

    $ rbenv sudo gem install thin
    
now to run a thin generator

    $ rbenv sudo thin install
    
if you want to have thin start on startup then run this generator
    
    $ rbenv sudo /usr/sbin/update-rc.d -f thin defaults
    
Now let's setup a thin config.  Put this inside `/etc/thin/zone.yml`

    chdir: /var/apps/zone1/current
	environment: staging
	address: 0.0.0.0
	port: 5000
	timeout: 30
	log: /var/apps/zone1/shared/log/thin.log
	socket: /var/apps/zone1/shared/tmp/thin.sock
	max_conns: 1024
	max_persistent_conns: 100
	require: []
	wait: 30
	servers: 3
	daemonize: true
	

##### 3.

Make sure you can log in as the deploy user with an ssh key.

We should already have our public key inside `/root/.ssh/authorized_keys`.  Let's confirm we do and then copy it to `/home/deploy/.ssh/authorized_keys`.  If you don't, simply copy your public key into authorized_keys.

    $ sudo cat /root/.ssh/authorized_keys
    
This should output the public key you're using.
    
    $ mkdir ~/.ssh
    
    $ sudo cp /root/.ssh/authorized_keys ~/.ssh/authorized_keys
    
    $ sudo chown deploy:deploy ~/.ssh/authorized_keys
    
Now restart the ssh daemon.

    $ sudo service ssh restart

Now you can login as deploy, let's get back to our local tty prompt.

    $ exit
    
You may have to exit many times depending on how much session jumping you did.  Just make sure you're logged out and back at your local tty prompt.

    $ ssh -i ~/.ssh/my_private_key_name deploy@my_ip_or_domain -vv
    
At this point you'll see a lot of output.  Confirm that ssh is trying to authenticate with your private key.  You should be logged in.  If not, the first place I would check is to make sure the deploy user's ssh folder and keys have the correct permissions.
    

##### 4.

#### Ready to deploy!

First let's create a dir we have permissions to write to with our deploy user.

    sudo mkdir /var/apps
    sudo chown deploy:deploy /var/apps

Exit out to your local tty prompt and push the app.

    cap production deploy:check
    
You'll receive an error for linked files and directories, specifcally it won't find `.env`.  Check your local config/deploy.rb and you'll find a list of linked_files you need to manually copy over to the server.  From inside your local zone1 copy

    scp .env config/application.rb config/database.yml config/sunspot.yml config/resque.yml config/application.yml zoned:/vars/apps/zone1/shared/

    scp -r log/ system/ public/static/ solr/ zoned:/var/apps/zone1/shared

Go into your shared dir and move all the config files inside your config/ dir on the remote host.

Once you've done that you should be able to get further into the deploy with

    cap production deploy

You will have some bundler failures.  Log into the server and try to manually install the gems.  This should give you a good idea what library headers you're missing.  There will probably be a good number of them.  You can just keep going with the guide and come back to the deploy as the specifics will grab most of the lib headers you need.


### Nginx Specifics

You'll need to configure nginx's application specific config for a couple reasons

-  to alias the downloadable files folder so that nginx will handle download management instead of the app server.  So that with rails [send_file](http://apidock.com/rails/ActionController/DataStreaming/send_file) method, the default headers will direct nginx to handle the request.

- to setup nginx as a reverse proxy for thin


The config file can be found at (or you may need to make it)

    
    /usr/local/nginx/sites-available/zone1
        
or

    /etc/nginx/sites-available/zone1
    
an example config with a files download alias path - *note the trailing forward slashes*


	upstream zone1 {

  		server unix:////var/apps/zone1/shared/tmp/thin.0.sock;

  		server unix:////var/apps/zone1/shared/tmp/thin.1.sock;

  		server unix:////var/apps/zone1/shared/tmp/thin.2.sock;

	}

	server {
	  listen 80;
	  server_name your_domain.com; #replace with your server specifcs
	  root /var/apps/zone1/current/public;
	
	  location / {
	    proxy_pass http://zone1; # match the name of upstream directive which is defined above
	    proxy_set_header Host $host;
	    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	  }
	  location /files/ {
	            internal;
	            alias /var/app/zone1/current/downloads/;
	  }
	}

Finally, remember to symlink `zone1` to `/etc/niginx/sites-enabled/` and delete the `default` enabled link so that nginx will default to your config.


### Solr Install and Specifics

Use the easy method in [this guide](https://www.digitalocean.com/community/tutorials/how-to-install-solr-on-ubuntu-14-04) to install solr

There seems to be no standard location for the solr conf files between versions.  I've found that once you've setup solr and tomcat, it's best to startup the application and visit

    exampledomain.com:#{the_solr_port}/admin/
      
This will allow you to select the `schema.xml` and see its contents.  Now locate all schema.xml's on your server with

    # find / -name 'schema.xml'
    
You should find three or four schema.xml files inside solr directories.  The configuration file that my solr used as its default happened to be the one located inside my sunspot gem inside my rbenv gem management directory tree.

Once you find the correct `schema.xml` you will have to manually copy it into the right location from your app.

### PostgresQL

    $ sudo apt-get update
    $ sudo apt-get install postgresql postgresql-contrib libpq-dev
    
Now log into the postgres user

    $ sudo -i -u postgres
    
Create the zone1 user with the user/passw you'll use in your `database.yml`

    postgres$ createuser --pwprompt
    
log into postgres, and create the database set to be owned by zone1 user.

    postgres$ psql
    
    postgres=#create database with owner = zone1;
    
    postgres=# \quit
    
 Now exit out into the deploy user and `cd /var/apps/zone1/current`
 
    $ RAILS_ENV=production bundle exec rake db:migrate
    
    $ RAILS_ENV=production bundle exec rake db:seed
    
Now you have a running database.  Let's go back to our local rails app and do one more `cap production deploy` and you should have your app up and running at the domain you've specified in the nginx config.


Notes on Stack, Dependencies
========
* Authentication: devise gem + devise_harvard_auth_proxy
* Authorization: acl9
* Ajax-upload tool: plupload
* Search: solr, sunspot
* Tagging: acts_as_taggable_on 
* JavaScript dependencies: jQuery, jQuery UI
* Pagination: will_paginate
* File Metadata: fits
* Background Jobs: resque + redis
* Performance: Rails low-level caching to local disk storage
* Image processing: ImageMagick, RMagick gem

apache/nginx + passenger
--------
* must install mod_xsendfile, see https://tn123.org/mod_xsendfile/
** You must be sure to verify the module is loading in Apache, use apachectl -t -D DUMP_MODULES
* must set the following directives in VirtualHost
** XSendFile On
** XSendFilePath $RAILS_ROOT/assets
** XSendFilePath $RAILS_ROOT/uploads
** XSendFilePath $RAILS_ROOT/downloads
** XSendFilePath $RAILS_ROOT/public
** In general, make sure to add XSendFilePath to whitelist any location you want users to be able to download from
* must configure Rails enviornment to include  
    # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache

nginx
--------
* no additional configuration of websever is required
* this application has not been tested with nginx.  Be sure to test downloads are not empty files.
* must configure Rails enviornment to include 
    # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx


Required cron jobs
========
Temporary files are created by stored_files_controller#download_set in $RAILS_ROOT/downloads.
You'll want a cron job to clear old files out of that directory periodically. E.g.
# expire download files after 120 minutes
20 * * * * nice find $RAILS_ROOT/download/ -mindepth 1 -maxdepth 1 -mmin +120 -print0 | xargs -0 -r rm -rf

You'll want to a cron job to clear the soft-deleted stored files which have expired.
This rake job loads the Rails enviornment, so please execute as a user with appropriate permissions.
0 0 * * * cd $RAILS_ROOT && bundle exec rake zone_one:hard_delete_expired_stored_files


Solr Notes
========
* To restart tomcat, run *service tomcat6 restart* (or whatever version of tomcat is running)
* To reindex solr, run *rake sunspot:reindex*
* To view other solr tasks, run *rake --tasks | grep sunspot*


Testing
========
* To begin testing, define the test database in config/database.yml
* rake camp:rebuild RAILS_ENV=test
* Testing dependencies include rspec, factory_girl, shoulda, database_cleaner, remarkable
* *rake spec* will run full suite of tests
* *rspec filename* will run tests from that file


SFTP / Proftpd setup and use
========
You'll need to update your proftpd.conf file to setup the proper paths, database
connection info, and SSL certificate.

The main configuration requirement is the SQLDefaultUID and SQLDefaultGID directive. 
Use the same UID and GID as the user running your webserver.  That user needs
to be able to `cd` into a virtual user's homedir, and run a `ls` there.

For an example please review var/proftpd.conf.

License
========
This application is released under a AGPLv3 license.

Copyright President and Fellows of Harvard College, 2012

