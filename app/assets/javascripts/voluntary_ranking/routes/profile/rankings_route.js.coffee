Volontariat.ProfileRankingsRoute = Ember.Route.extend
  model: (params) ->
    @controllerFor('profile.rankings').set('yourRanking', true); @controllerFor('profile.rankings').set('yourRankingClass', 'your_ranking_button btn active'); 
    @controllerFor('profile.rankings').set('globalRankingClass', 'global_ranking_button btn')
    @controllerFor('profile.rankings').set('adjective', params.adjective)
    @controllerFor('profile.rankings').set('negativeAdjective', params.negative_adjective)
    @controllerFor('profile.rankings').set('topic', params.topic)
    @controllerFor('profile.rankings').set('scope', params.scope)
    @controllerFor('profile.rankings').set('page', parseInt(params.page))
   
    if Volontariat.User.current() == undefined
      alert 'Please sign in to see your ranking!'
    else
      @store.findQuery(
        'user_ranking_item',
        user_id: Volontariat.User.current().id, adjective: params.adjective, 
        negative_adjective: params.negative_adjective, topic: params.topic, 
        scope: params.scope, page: params.page
      )
    
  setupController: (controller, model) ->
    controller.send('goToPageWithoutRedirect', controller.get('page'))
    controller.set('content', model)
    
  renderTemplate: ->
    @render 'user/rankings/details'