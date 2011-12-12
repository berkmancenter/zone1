Data Setup
========

rake db:rebuild RAILS_ENV=development

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

apache/nginx + passenger
--------
* must install mod_xsendfile, see https://tn123.org/mod_xsendfile/
** You must be sure to verify the module is loading in Apache, use apachectl -t -D DUMP_MODULES
* must set the following directives in VirtualHost
** XSendFile On
** XSendFilePath $RAILS_ROOT/assets
** XSendFilePath $RAILS_ROOT/uploads
** XSendFilePath $RAILS_ROOT/tmp
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
Temporary files are created by stored_files_controller#download_set in $RAILS_ROOT/tmp.  These
files must be cleared periodically by running rake zone_one:remove_download_sets.  This task will
delete zip files older than 1 hour.


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
