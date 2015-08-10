Volontariat.RankingsShowController = Volontariat.ArrayController.extend(Volontariat.RankingController, Volontariat.PaginationController,
  listContext: 'Global', yourRanking: false, routeName: ''  
  yourRankingClass: 'btn', globalRankingClass: 'btn active'
  thingType: '', adjective: '', negativeAdjective: '', topic: '', scope: ''
  paginationResource: 'ranking_item', paginationRoute: 'rankings.show'
  
  actions:
  
    reload: ->
      @set(
        'model', 
        @store.find(
          'ranking_item', 
          adjective: @get('adjective'), negative_adjective: @get('negativeAdjective'), 
          topic: @get('topic'), scope: @get('scope'), page: @get('page')
        )
      )
)