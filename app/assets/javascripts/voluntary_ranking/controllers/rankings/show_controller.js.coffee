VoluntaryOnEmberjs.RankingsShowController = VoluntaryOnEmberjs.ArrayController.extend(VoluntaryOnEmberjs.RankingController,
  listContext: 'Global', yourRanking: false, routeName: ''  
  yourRankingClass: 'btn', globalRankingClass: 'btn active'
  thingType: '', adjective: '', negativeAdjective: '', topic: '', scope: ''
  
  actions:
  
    reload: ->
      @set(
        'model', 
        @store.find(
          'ranking_item', 
          adjective: @get('adjective'), negative_adjective: @get('negativeAdjective'), 
          topic: @get('topic'), scope: @get('scope')
        )
      )
)