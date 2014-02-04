VoluntaryOnEmberjs.UserRankingItem = DS.Model.extend
  user: DS.belongsTo('VoluntaryOnEmberjs.User')
  #ranking: DS.belongsTo('VoluntaryOnEmberjs.Ranking')
  #thing: DS.belongsTo('VoluntaryOnEmberjs.Thing', { polymorphic: true })
  #thing: DS.belongsTo('VoluntaryOnEmberjs.Thing')
  #thing: DS.belongsTo('VoluntaryOnEmberjs.Thing',
  #  polymorphic: true
  #)
  position: DS.attr('number')
  
  thingId: DS.attr('number')
  thingType: DS.attr('string')
  thingName: DS.attr('string')
  best: DS.attr('boolean')
  stars: DS.attr('number')
  is1StarClass: (-> @get('stars') >= 1).property('stars')
  is2StarClass: (-> @get('stars') >= 2).property('stars')
  is3StarClass: (-> @get('stars') >= 3).property('stars')
  is4StarClass: (-> @get('stars') >= 4).property('stars')
  is5StarClass: (-> @get('stars') == 5).property('stars')
  
  url: (->
    '/users/' + @get('user.id') + '/ranking_items'
  ).property('user')