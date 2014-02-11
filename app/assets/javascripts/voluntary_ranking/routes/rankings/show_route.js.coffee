VoluntaryOnEmberjs.RankingsShowRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('rankings.show').set('yourRanking', false); @controllerFor('rankings.show').set('yourRankingClass', 'btn'); 
    @controllerFor('rankings.show').set('globalRankingClass', 'btn active')
    @controllerFor('rankings.show').set('adjective', params.adjective)
    @controllerFor('rankings.show').set('negativeAdjective', params.negative_adjective)
    @controllerFor('rankings.show').set('topic', params.topic)
    @controllerFor('rankings.show').set('scope', params.scope)
    @controllerFor('rankings.show').set('page', parseInt(params.page))
    
    @store.find(
      'ranking_item',
      adjective: params.adjective, negative_adjective: params.negative_adjective, topic: params.topic, 
      scope: params.scope, page: params.page
    )
    
  setupController: (controller, model) ->
    controller.send('goToPageWithoutRedirect', controller.get('page'))
    controller.set('model', model)
    
  renderTemplate: ->
    @render 'voluntary_ranking/templates/rankings/show'