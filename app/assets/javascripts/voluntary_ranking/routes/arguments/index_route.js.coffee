Volontariat.ArgumentsIndexRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('arguments.index').set 'page', parseInt(params.page)
    #@controllerFor('arguments.index').set 'thingName', @modelFor('thing')._internalModel._data.name
    #@controllerFor('arguments.index').set 'thingName', @modelFor('thing').name
    @controllerFor('arguments.index').set 'thingName', window.location.hash.split('/')[2]
    
    @store.query('argument', argumentable_type: 'Thing', argumentable_id: @modelFor('thing').id, page: params.page).then (result) =>
      @controllerFor('arguments.index').set 'metadata', result.get('meta')
      result
  
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