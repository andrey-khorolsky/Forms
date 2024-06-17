# Database entities

- [Database entities](#database-entities)
  - [Diagrams](#diagrams)
    - [Key based diagram](#key-based-diagram)
    - [ERD](#erd)
  - [Postgres entities](#postgres-entities)
    - [Answer](#answer)
    - [FieldType](#fieldtype)
    - [GroupMember](#groupmember)
    - [Group](#group)
    - [Permission](#permission)
    - [Role](#role)
    - [Survey](#survey)
    - [User](#user)
  - [Mongo entities](#mongo-entities)
    - [AnswerDatum](#answerdatum)
    - [Question](#question)

___
## Diagrams

[All diagrams](/doc/database_diagrams.pdf)

### Key based diagram
Модель основанная на ключах
![key_based_diagram](/doc/img/key_based.jpg)

### ERD

ERD for active_record models (without mongo)
![erd](/doc/img/erd_image.png)

## Postgres entities

### Answer

Main data for answer, without all answers (there are in AnswerDatum)


### FieldType

Just field's types list. idk


### GroupMember

Association between Group and Members. Member - Group or User.


### Group

Group with members. Can contain users and another groups. Group A can't contain group B that contains group A, maybr through another group.


### Permission

Permission for owners (group or user) to entity (survey or group) with role.


### Role

Just roles list.


### Survey

Main data for survey, without questions (there are in Question model).


### User

User. Person or company, it's same.




## Mongo entities

### AnswerDatum

Data (all answers) for Answer entity.

### Question

All questions for Survey entity.


[postgres_entities]: #postgres-entities
[mongo_entities]: #mongo-entities
