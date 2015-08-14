Volontariat.RankingsIndexRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('rankings.index').set 'page', parseInt(params.page)
    @controllerFor('rankings.index').set 'thingName', @modelFor('thing').get('name')
    
    @store.query 'ranking', thing_id: @modelFor('thing').id, page: params.page
    
  setupController: (controller, model) ->
    controller.send('goToPageWithoutRedirect', controller.get('page'))
    controller.set('model', model)
