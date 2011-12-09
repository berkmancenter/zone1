Data Setup
========

rake db:rebuild

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

- apache/nginx + passenger
** if using apache
*** must install mod_xsendfile, see https://tn123.org/mod_xsendfile/
*** must configure Rails enviornment to include  
    # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache

** if using nginx
*** no additional configuration of websever is required
*** must configure Rails enviornment to include 
    # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

Solr Notes
========

* To restart tomcat, run *service tomcat6 restart* (or whatever version of tomcat is running)
* To reindex solr, run *rake sunspot:reindex*
* To view other solr tasks, run *rake --tasks*

Testing
========

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
