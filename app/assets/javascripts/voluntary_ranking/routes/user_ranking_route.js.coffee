Volontariat.UserRankingRoute = Ember.Route.extend
  model: (params) ->
    if Volontariat.User.current() != undefined && Volontariat.User.current().name.toLowerCase() == params.user_name.toLowerCase()
      @controllerFor('user_ranking').set('yourRanking', true)
    else
      @controllerFor('user_ranking').set('yourRanking', false)
    
    @controllerFor('user_ranking').set 'userName', params.user_name
    @controllerFor('user_ranking').set 'adjective', params.adjective
    @controllerFor('user_ranking').set 'negativeAdjective', params.negative_adjective
    @controllerFor('user_ranking').set 'topic', params.topic
    @controllerFor('user_ranking').set 'scope', params.scope
    @controllerFor('user_ranking').set 'page', parseInt(params.page)
   
    @store.query(
      'user_ranking_item',
      user_name: params.user_name, adjective: params.adjective, 
      negative_adjective: params.negative_adjective, topic: params.topic, 
      scope: params.scope, page: params.page
    )
    
  setupController: (controller, model) ->
    controller.send('goToPageWithoutRedirect', controller.get('page'))
    controller.set('content', model)
    
  renderTemplate: ->
    @render 'user/rankings/details'