Volontariat.ThingRoute = Ember.Route.extend
  model: (params) ->
    @store.find('thing', params.thing_id)