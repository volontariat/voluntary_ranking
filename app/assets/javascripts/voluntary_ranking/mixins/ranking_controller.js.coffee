Volontariat.RankingController = Em.Mixin.create
  page: 1
  
  anyItems: (-> @get('content.length') > 0).property('content')
  
  actions:  
    setGlobalRanking: ->
      @set('yourRanking', false); @set('yourRankingClass', 'your_ranking_button btn'); @set('globalRankingClass', 'global_ranking_button btn active')
      
    setYourRanking: ->
      @set('yourRanking', true); @set('yourRankingClass', 'your_ranking_button btn active'); @set('globalRankingClass', 'global_ranking_button btn')
      
    getRanking: ->
      if @get('yourRanking')
        @transitionToRoute('profile.rankings', @get('adjective'), @get('negativeAdjective'), @get('topic'), @get('scope'), @get('page'))
      else
        @transitionToRoute('rankings.show', @get('adjective'), @get('negativeAdjective'), @get('topic'), @get('scope'), @get('page'))