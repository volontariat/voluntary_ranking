VoluntaryOnEmberjs.User = VoluntaryOnEmberjs.User.extend
  user_ranking_items: DS.hasMany('VoluntaryOnEmberjs.UserRankingItem', embedded: true)