# _Billy_
[![Build Status](https://travis-ci.org/bigzoo/billy.svg?branch=master)](https://travis-ci.org/bigzoo/billy)

##### Billy pays your bills. Give it a try today.

## Technologies Used

Application: Ruby, Sinatra,
Testing: Rspec, Capybara<br>
Database: Postgres

Installation
------------

```
$ git clone https://github.com/bigzoo/billy
```

Install required gems:
```
$ bundle install
```

Create databases:
```
rake db:create
rake db:migrate
```

Start the webserver:
```
$ ruby app.rb
```

Navigate to `localhost:4567` in browser.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/bigzoo/billy). 


License
-------

/* Copyright (C) Billy Systems, Inc - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Chris Nyaga <me@bigzoo.me>, July 2017
 */
