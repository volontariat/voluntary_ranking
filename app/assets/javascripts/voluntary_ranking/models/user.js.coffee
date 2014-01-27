VoluntaryOnEmberjs.User = VoluntaryOnEmberjs.User.extend
  user_ranking_items: DS.hasMany('VoluntaryOnEmberjs.UserRankingItem', embedded: true)
  
VoluntaryOnEmberjs.User.reopenClass VoluntaryOnEmberjs.Singleton,
  name: DS.attr('string')
  email: DS.attr('string')

  createCurrent: ->
    userJson = PreloadStore.get("currentUser")
    return VoluntaryOnEmberjs.User.createRecord(userJson) if userJson
    null