VoluntaryOnEmberjs.User = VoluntaryOnEmberjs.User.extend
  user_ranking_items: DS.hasMany('VoluntaryOnEmberjs.UserRankingItem', embedded: true)
  
VoluntaryOnEmberjs.User.reopenClass VoluntaryOnEmberjs.Singleton,
  createCurrent: ->
    userJson = PreloadStore.get("currentUser")
    
    # TODO: build record from JSON to save find query without posting it after next store commit
    #return VoluntaryOnEmberjs.User.createRecord(userJson) if userJson
    
    return VoluntaryOnEmberjs.User.find(userJson.id) if userJson
    
    null