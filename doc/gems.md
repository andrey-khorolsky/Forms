# Gems

## Vizualization

### [Rails-erd](https://github.com/preston/railroady)

just `bundle exec erd` to generate erd diagram

or `rails erd polymorphism=true exclude="ApplicationRecord, ActionMailbox::Record, ActionText::Record, ActiveStorage::Record"` to better generation


### [Railroady](https://github.com/preston/railroady)

`rake diagram:all` for all

or for models `railroady -M -e app/models/application_record.rb | dot -Tsvg > doc/models.svg`
