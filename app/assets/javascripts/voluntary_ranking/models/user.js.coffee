VoluntaryOnEmberjs.User = VoluntaryOnEmberjs.User.extend
  user_ranking_items: DS.hasMany('userRankingItem', embedded: true)
  
VoluntaryOnEmberjs.User.reopenClass VoluntaryOnEmberjs.Singleton,
  createCurrent: ->
    userJson = PreloadStore.get("currentUser")
    
    return userJson
    
    # TODO: build record from JSON to save find query without posting it after next store commit
    #return VoluntaryOnEmberjs.__container__.lookup('store:main').createRecord(userJson) if userJson
    
    if userJson
      return VoluntaryOnEmberjs.__container__.lookup('store:main').find('user', userJson.id)
      
      VoluntaryOnEmberjs.__container__.lookup('store:main').find('user', userJson.id).then (current_user) ->
        VoluntaryOnEmberjs.currentUser = current_user
        
      return VoluntaryOnEmberjs.currentUser
    
    null