Volontariat.UserRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('user').set 'metadata', {}
    @controllerFor('user').set 'name', params.name
    @controllerFor('user').set 'page', params.page
    
    Ember.$.getJSON(
      "/api/v1/rankings?user_name=#{params.name}&page=#{params.page}"
    ).then (json) =>
      @controllerFor('user').set 'metadata', json.meta
      
      @controllerFor('user').set 'rankings', $.map json.rankings, (ranking, i) ->
        ranking.negativeAdjective = ranking.negative_adjective
        ranking
    
      { name: params.name }

  setupController: (controller, model) ->
    controller.send('goToPageWithoutRedirect', controller.get('page'))
    controller.set('model', model)