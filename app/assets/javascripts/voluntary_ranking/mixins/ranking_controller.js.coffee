VoluntaryOnEmberjs.RankingController = Em.Mixin.create
  actions:  
    setGlobalRanking: ->
      @set('yourRanking', false); @set('yourRankingClass', 'btn'); @set('globalRankingClass', 'btn active')
      
    setYourRanking: ->
      @set('yourRanking', true); @set('yourRankingClass', 'btn active'); @set('globalRankingClass', 'btn')
      
    getRanking: ->
      if @get('yourRanking')
        @transitionToRoute('profile.rankings', @get('adjective'), @get('negativeAdjective'), @get('topic'), @get('scope'))
      else
        @transitionToRoute('rankings.show', @get('adjective'), @get('negativeAdjective'), @get('topic'), @get('scope'))