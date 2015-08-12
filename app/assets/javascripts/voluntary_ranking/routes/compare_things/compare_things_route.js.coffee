Volontariat.CompareThingsRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('compare_things').set 'leftThingName', params.left_thing_name
    @controllerFor('compare_things').set 'rightThingName', params.right_thing_name
    
    unless window.top.location.hash.indexOf('/arguments/') > -1
      alert 'load arguments: ' + params.left_thing_name + ', ' + params.right_thing_name
      @transitionTo('compare_things.arguments', params.left_thing_name, params.right_thing_name, 'both', 1)
    
    { leftThingName: params.left_thing_name, rightThingName: params.right_thing_name }