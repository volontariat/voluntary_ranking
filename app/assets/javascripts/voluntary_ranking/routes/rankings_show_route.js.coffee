VoluntaryOnEmberjs.RankingsShowRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('rankings.show').set('adjective', params.adjective)
    @controllerFor('rankings.show').set('negativeAdjective', params.negative_adjective)
    @controllerFor('rankings.show').set('topic', params.topic)
    @controllerFor('rankings.show').set('scope', params.scope)
    
    VoluntaryOnEmberjs.RankingItem.find
      adjective: params.adjective, negativeAdjective: params.negative_adjective, topic: params.topic, 
      scope: params.scope
      
    #VoluntaryOnEmberjs.UserRankingItem.find
    #  user_id: VoluntaryOnEmberjs.currentUser['id']
    #  thingType: attributes['thingType'], adjective: attributes['adjective'], 
    #  negativeAdjective: attributes['negativeAdjective'], topic: attributes['topic'], 
    #  scope: attributes['scope']
    
  setupController: (controller, model) ->
    @controllerFor('rankings.show').set('model', model)
    
  renderTemplate: ->
    @render 'rankings.show', controller: 'rankings.show'   