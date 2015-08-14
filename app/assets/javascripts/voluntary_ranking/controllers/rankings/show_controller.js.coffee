Volontariat.RankingsShowController = Volontariat.Controller.extend(Volontariat.RankingController, Volontariat.PaginationController,
  yourRanking: false, routeName: ''  
  yourRankingClass: 'your_ranking_button btn btn-default', globalRankingClass: 'global_ranking_button btn btn-default active'
  thingType: '', adjective: '', negativeAdjective: '', topic: '', scope: ''
  paginationResource: 'ranking_item', paginationRoute: 'rankings.show'
  
  actions:
  
    reload: ->
      @set(
        'model', 
        @store.query(
          'ranking_item', 
          adjective: @get('adjective'), negative_adjective: @get('negativeAdjective'), 
          topic: @get('topic'), scope: @get('scope'), page: @get('page')
        )
      )
)