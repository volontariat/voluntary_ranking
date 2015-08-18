Volontariat.CompareThingsArgumentsRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('compare_things.arguments').set 'leftThingName', @modelFor('compare_things').leftThingName
    @controllerFor('compare_things.arguments').set 'rightThingName', @modelFor('compare_things').rightThingName
    @controllerFor('compare_things.arguments').set 'page', parseInt(params.page)
    
    Ember.$.getJSON("/api/v1/things/#{@modelFor('compare_things').leftThingName}/vs/#{@modelFor('compare_things').rightThingName}/arguments.json?argumentable_type=Thing&page=#{params.page}&side=#{params.side}").then (json) =>
      @controllerFor('compare_things.arguments').set('metadata', json.meta)  
      json.arguments
      
  setupController: (controller, model) ->
    controller.send('goToPageWithoutRedirect', controller.get('page'))
    controller.set('model', model)
    
  renderTemplate: ->
    @render 'compare_things.arguments'