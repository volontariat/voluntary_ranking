VoluntaryOnEmberjs.ProfileRankingsRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('profile.rankings').set('adjective', params.adjective)
    @controllerFor('profile.rankings').set('negativeAdjective', params.negative_adjective)
    @controllerFor('profile.rankings').set('topic', params.topic)
    @controllerFor('profile.rankings').set('scope', params.scope)
    
    VoluntaryOnEmberjs.UserRankingItem.find
      user_id: VoluntaryOnEmberjs.currentUser['id']
      thingType: attributes['thingType'], adjective: attributes['adjective'], 
      negativeAdjective: attributes['negativeAdjective'], topic: attributes['topic'], 
      scope: attributes['scope']

  renderTemplate: ->
    @render 'voluntary_ranking/templates/user/rankings/show'