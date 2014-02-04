VoluntaryOnEmberjs.ProfileRankingsRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('profile.rankings').set('yourRanking', true); @controllerFor('profile.rankings').set('yourRankingClass', 'btn active'); 
    @controllerFor('profile.rankings').set('globalRankingClass', 'btn')
    @controllerFor('profile.rankings').set('adjective', params.adjective)
    @controllerFor('profile.rankings').set('negativeAdjective', params.negative_adjective)
    @controllerFor('profile.rankings').set('topic', params.topic)
    @controllerFor('profile.rankings').set('scope', params.scope)
    VoluntaryOnEmberjs.UserRankingItem.find
      user_id: VoluntaryOnEmberjs.User.current().id, adjective: params.adjective, 
      negative_adjective: params.negative_adjective, topic: params.topic, 
      scope: params.scope

  renderTemplate: ->
    @render 'voluntary_ranking/templates/user/rankings/show'