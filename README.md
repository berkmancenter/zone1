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
* rails3_acts_as_paranoid has been forked from a branch which had provided Rails 3.1.x.  Mainline did not support as of this commit.

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


Solr Notes
========
* To restart tomcat, run *service tomcat6 restart* (or whatever version of tomcat is running)
* To reindex solr, run *rake sunspot:reindex*
* To view other solr tasks, run *rake --tasks | grep sunspot*


Testing
========
* rake db:rebuild RAILS_ENV=test
* Testing dependencies include rspec, factory_girl, shoulda, database_cleaner,
  remarkable, rcov 
* To begin testing, define test database in config/database.yml
* *rake spec* will run full suite of tests
* *rspec filename* will run tests from that file
* *rake rcov:rspec* will generate coverage data with rcov, copy to public, visit http://<root_url>/coverage/index.html)


Rails Best Practices Output
========
* bundle exec rails_best_practices -f html .
* mv rails_best_practices.html public/rbp.html
* visit http://<your_host>/rbp.html


SFTP / Proftpd setup and use
========
You'll need to update your proftpd.conf file to setup the proper paths, database
connection info, and SSL certificate.

The main configuration requirement is the SQLDefaultUID and SQLDefaultGID directive. 
Use the same UID and GID as the user running your webserver.  That user needs
to be able to `cd` into a virtual user's homedir, and run a `ls` there.

For an example please review var/proftpd.conf.


CACHING
=========
AccessLevel
-------------
Cached methods: .all
Caches will be destroyed: after_update, after_create, after_destroy

Flag
-------------
Cached methods: .all
Caches will be destroyed: after_update, after_create, after_destroy

Group
-------------
Cached methods: .cached_viewable_users(right)
Caches will be destroyed: after_update, after_create, after_destroy

License
------------
Cached methods: .all
Caches will be destroyed: after_update, after_create, after_destroy

MimeType
------------
Cached methods: .all, .blacklisted_extensions
Caches will be destroyed: after_update, after_create, after_destroy

MimeTypeCategory
------------
Cached methods: .all
Caches will be destroyed: after_update, after_create, after_destroy

Preference
------------
Cached methods: .all
Caches will be destroyed: after_update, after_create, after_destroy

Role
------------
Cached methods: .user_rights, .cached_viewable_users(right)
Caches will be destroyed: after_update, after_create, after_destroy

StoredFile
--------------
Cached methods: #tag_list, .cached_viewable_users(id)
Caches will be destroyed: after_update, before_destroy

User
-----------
Cached methods: #all_rights, .users_with_right, .cached_viewable_users, can_view_cached?, .all
Caches will be destroyed: after_update, after_create, after_destroy

Warden::Manager (see application_controller)
-----------
Logged out user's rights cache will be destroyed: after_authentication
