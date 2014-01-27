VoluntaryOnEmberjs.IndexController = VoluntaryOnEmberjs.ArrayController.extend
  listContext: 'Global', yourList: false,
  thingType: '', adjective: '', negativeAdjective: '', topic: '', scope: ''
  
  actions:  
    getRanking: ->
      @transitionToRoute('rankings.show', @get('adjective'), @get('negativeAdjective'), @get('topic'), @get('scope'))