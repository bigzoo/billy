# _Billy_
[![Build Status](https://travis-ci.org/bigzoo/billy.svg?branch=master)](https://travis-ci.org/bigzoo/billy)

##### This application  that  pays your bills on behalf.All you need to do is to top-up.

## Technologies Used

Application: Ruby, Sinatra, Active Record<br>
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
rake db:schema:load
```

Start the webserver:
```
$ ruby app.rb
```

Navigate to `localhost:4567` in browser.

## Versioning

I use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/bigzoo/billy). 


License
-------

This project is licensed under the MIT License 
