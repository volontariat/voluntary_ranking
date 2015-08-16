Volontariat.RankingController = Em.Mixin.create
  page: 1
  
  anyItems: (-> @get('content.length') > 0).property('content')
  
  actions:  
    setGlobalRanking: ->
      @set('yourRanking', false); @set('yourRankingClass', 'your_ranking_button btn-default btn'); @set('globalRankingClass', 'global_ranking_button btn btn-default active')
      
      unless @get('adjective') == undefined || @get('adjective').toString().trim() == '' ||
      @get('negativeAdjective') == undefined || @get('negativeAdjective').toString().trim() == '' || 
      @get('topic') == undefined || @get('topic').toString().trim() == '' || 
      @get('scope') == undefined || @get('scope').toString().trim() == ''
        @send 'getRanking' 
        
    setYourRanking: ->
      @set('yourRanking', true); @set('yourRankingClass', 'your_ranking_button btn btn-default active'); @set('globalRankingClass', 'global_ranking_button btn btn-default')
      
      unless @get('adjective') == undefined || @get('adjective').toString().trim() == '' ||
      @get('negativeAdjective') == undefined || @get('negativeAdjective').toString().trim() == '' || 
      @get('topic') == undefined || @get('topic').toString().trim() == '' || 
      @get('scope') == undefined || @get('scope').toString().trim() == ''
        @send 'getRanking'
        
    getRanking: ->
      @transitionToRoute 'no_data'
      
      if @get('yourRanking')
        @transitionToRoute('profile.rankings', @get('adjective'), @get('negativeAdjective'), @get('topic'), @get('scope'), @get('page'))
      else
        @transitionToRoute('rankings.show', @get('adjective'), @get('negativeAdjective'), @get('topic'), @get('scope'), @get('page'))