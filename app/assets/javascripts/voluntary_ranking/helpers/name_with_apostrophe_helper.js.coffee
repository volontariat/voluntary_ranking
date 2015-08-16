Ember.Handlebars.helper 'name-with-apostrophe', (name, options) ->
  if name[name.length - 1].toLowerCase() == 's'
    "#{name}'"
  else
    "#{name}'s"
