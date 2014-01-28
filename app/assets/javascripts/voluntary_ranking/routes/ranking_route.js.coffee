VoluntaryOnEmberjs.RankingRoute = Ember.Route.extend
  model: (params) ->
    #alert 'ok3:' + params.topic
    #@controllerFor('profile.rankings').set('adjective', params.adjective)
    #@controllerFor('profile.rankings').set('negativeAdjective', params.negative_adjective)
    @controllerFor('ranking').set('topic', params.topic)
    #@controllerFor('profile.rankings').set('scope', params.scope)
    
    #VoluntaryOnEmberjs.UserRankingItem.find
    #  user_id: VoluntaryOnEmberjs.currentUser['id']
    #  thingType: attributes['thingType'], adjective: attributes['adjective'], 
    #  negativeAdjective: attributes['negativeAdjective'], topic: attributes['topic'], 
    #  scope: attributes['scope']

  renderTemplate: ->
    @render 'voluntary_ranking/templates/rankings/show'