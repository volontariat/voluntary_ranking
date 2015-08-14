Volontariat.ArgumentsIndexRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('arguments.index').set 'page', parseInt(params.page)
    @controllerFor('arguments.index').set 'thingName', @modelFor('thing')._internalModel._data.name
    
    @store.query 'argument', thing_id: @modelFor('thing').id, page: params.page
  
  setupController: (controller, model) ->
    controller.send('goToPageWithoutRedirect', controller.get('page'))
    controller.set('model', model)
    
  actions:
    
    openModal: (modalName) ->
      @render modalName,
        into: "arguments.index"
      $('#modal').modal('show')
      $('#modal').removeClass('hide')
        
    closeModal: ->
      $('#modal').modal('hide')
      $('#modal').addClass('hide')
      $('body').removeClass('modal-open')
      $('.modal-backdrop').remove()