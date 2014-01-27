VoluntaryOnEmberjs.RankingsShowController = VoluntaryOnEmberjs.ArrayController.extend
  listContext: 'Global', yourList: false, routeName: ''  
  thingType: '', adjective: '', negativeAdjective: '', topic: '', scope: ''
  thingName: '', best: true, stars: 3
  isBestClass: 'btn active', isWorstClass: 'btn'
  is1Star: '', is2Star: '', is3Star: 'active', is4Star: '', is5Star: ''
 
  actions:  
    getRanking: ->
      console.log '/' + @get('adjective') + '/' + @get('negativeAdjective') + '/' + @get('topic') + '/' + @get('scope')
      @transitionToRoute('rankings.show', @get('adjective'), @get('negativeAdjective'), @get('topic'), @get('scope'))
