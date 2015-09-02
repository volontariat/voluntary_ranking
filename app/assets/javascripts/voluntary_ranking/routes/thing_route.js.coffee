Volontariat.ThingRoute = Ember.Route.extend
  model: (params) ->
    unless window.top.location.hash.indexOf('/rankings/page/') > -1 || window.top.location.hash.indexOf('/arguments/page/') > -1
      @transitionTo('rankings.index', params.name, 1)
    
    @controllerFor('thing').set 'name', params.name
    
    thingIds = []
    
    if Cookies.get('thingComparisonList') == undefined
      @controllerFor('thing').set 'thingComparisonListCount', 0
    else
      thingIds = Cookies.getJSON('thingComparisonList')
      @controllerFor('thing').set 'thingComparisonListCount', thingIds.length
      
    @store.find('thing', params.name).then (thing) =>
      @controllerFor('thing').set 'thingId', thing.id
      @controllerFor('thing').set 'onComparisonList', jQuery.inArray(thing.id, thingIds) > -1
