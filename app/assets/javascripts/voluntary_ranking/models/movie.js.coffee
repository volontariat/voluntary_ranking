VoluntaryOnEmberjs.Movie = DS.Model.extend
  #rankings: DS.hasMany('ranking')
  userRankingItems: DS.hasMany('userRankingItem')
  
  name: DS.attr('string')