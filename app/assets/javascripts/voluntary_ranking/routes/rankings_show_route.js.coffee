VoluntaryOnEmberjs.RankingsShowRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('rankings.show').set('adjective', params.adjective)
    @controllerFor('rankings.show').set('negativeAdjective', params.negative_adjective)
    @controllerFor('rankings.show').set('topic', params.topic)
    @controllerFor('rankings.show').set('scope', params.scope)
    
    VoluntaryOnEmberjs.RankingItem.find
      adjective: params.adjective, negativeAdjective: params.negative_adjective, topic: params.topic, 
      scope: params.scope
      
  setupController: (controller, model) ->
    @controllerFor('rankings.show').set('model', model)
    
  renderTemplate: ->
    @render 'voluntary_ranking/templates/rankings/show'