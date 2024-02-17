# Database entities

* [ERD](#erd)
* [Postgres entities][postgres_entities]
    * [Answer](#answer)
    * [FieldType](#fieldtype)
    * [GroupMember](#groupmember)
    * [Group](#group)
    * [Permission](#permission)
    * [Role](#role)
    * [Survey](#survey)
    * [User](#user)
* [Mongo entities][mongo_entities]
    * [AnswerDatum](#answerdatum)
    * [Question](#question)

___

## ERD

ERD for active_record models (without mongo)
![erd](/doc/erd_image.png)

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
