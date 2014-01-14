VoluntaryOnEmberjs.Movie = DS.Model.extend
  #rankings: DS.hasMany('VoluntaryOnEmberjs.Ranking')
  userRankingItems: DS.hasMany('VoluntaryOnEmberjs.UserRankingItem')
  
  name: DS.attr('string')