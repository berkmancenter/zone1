Camp Setup
========

rake camp:rebuild RAILS_ENV=development

Notes on Stack, Dependencies
========

- Authentication: devise gem
- Authorization: acl9
- Ajax-upload tool: plupload
- Search: solr, sunspot
- Tagging: acts_as_taggable_on 
- JavaScript dependencies: jQuery, jQuery UI
- Pagination: will_paginate
- File Metadata: fits
- Background Jobs: resque + redis
- Performance: Rails low-level caching to local disk storage
- Image processing: ImageMagick, RMagick gem

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
These files must be cleared periodically by running rake zone_one:remove_download_sets. You'll
want a cron job to clear old files out of that directory periodically. E.g.
# expire download files after 120 minutes
20 * * * * nice find $RAILS_ROOT/download/ -mindepth 1 -maxdepth 1 -mmin +120 -print0 | xargs -0 -r rm -rf


Solr Notes
========

* To restart tomcat, run *service tomcat6 restart* (or whatever version of tomcat is running)
* To reindex solr, run *rake sunspot:reindex*
* To view other solr tasks, run *rake --tasks*

Testing
========

* rake db:rebuild RAILS_ENV=test
* Testing dependencies include rspec, factory_girl, shoulda, database_cleaner,
  remarkable, rcov 
* To begin testing, define test database in config/database.yml
* *rake spec* will run full suite of tests
* *rspec filename* will run tests from that file
* *rake rcov:rspec* will generate coverage data with rcov, visit http://<your_camp>/coverage/index.html)

RAILS BEST PRACTICES OUTPUT
========

* bundle exec rails_best_practices -f html .
* mv rails_best_practices.html public/rbp.html
* visit http://<your_camp>/rbp.html


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

