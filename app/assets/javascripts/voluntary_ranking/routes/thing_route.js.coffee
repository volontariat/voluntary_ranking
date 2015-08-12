Volontariat.ThingRoute = Ember.Route.extend
  model: (params) ->
    unless window.top.location.hash.indexOf('/rankings/page/') > -1 || window.top.location.hash.indexOf('/arguments/page/') > -1
      @transitionTo('rankings.index', params.thing_id, 1)
    
    @store.find('thing', params.thing_id)