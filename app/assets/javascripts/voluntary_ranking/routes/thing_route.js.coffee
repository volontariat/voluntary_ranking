Volontariat.ThingRoute = Ember.Route.extend
  model: (params) ->
    unless window.top.location.hash.indexOf('/rankings/page/') > -1 || window.top.location.hash.indexOf('/arguments/page/') > -1
      @transitionTo('rankings.index', params.name, 1)
    
    @controllerFor('thing').set 'name', params.name
    @store.find('thing', params.name)