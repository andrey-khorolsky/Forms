# Forms REST api

* [Ruby version](#ruby-version)
* [Database](#database)
  * [All entities](#all-entities)


## Ruby version
![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)

ruby 3.0.2


Rails 7.0.8


## Database
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![MongoDB](https://img.shields.io/badge/MongoDB-%234ea94b.svg?style=for-the-badge&logo=mongodb&logoColor=white)

PostgreSQL 14.10

MongoDB v4.4.28

Default invoked active_record. To create model (saffold etc) with mongo you should add flag `-o=mongoid`. The flags `-o, -orm` used to chose ORM to be invoked

All tables (entities) has the uuid id type, except field_type and mongo models

### [All entities](/doc/database_entities.md)



<!--
* System dependencies

* Configuration

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ... -->

