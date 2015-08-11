Volontariat.ArgumentsIndexRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('arguments.index').set 'page', parseInt(params.page)
    @controllerFor('arguments.index').set 'thingId', @modelFor('thing').id
    
    @store.find 'argument', thing_id: @modelFor('thing').id, page: params.page
  
  setupController: (controller, model) ->
    controller.send('goToPageWithoutRedirect', controller.get('page'))
    controller.set('model', model)
    
  actions:
    
    openModal: (modalName) ->
      @render modalName,
        into: "arguments.index"
        outlet: "modal"
      $('#modal').modal('show')
        
    closeModal: ->
      @disconnectOutlet
        outlet: "modal"
        parentView: "arguments.index"
      $('#modal').modal('hide')