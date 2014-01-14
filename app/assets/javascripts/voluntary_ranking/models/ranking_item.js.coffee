VoluntaryOnEmberjs.RankingItem = DS.Model.extend
  ranking: DS.belongsTo('VoluntaryOnEmberjs.Ranking')
  #thing: DS.belongsTo('VoluntaryOnEmberjs.Thing', { polymorphic: true })
  thingType: DS.attr('string')
  thingName: DS.attr('string')
  position: DS.attr('number')
  
  best: DS.attr('boolean')
  stars: DS.attr('number')
  topic: DS.attr('string')
  scope: DS.attr('string')
  #url: (->
  #  '/users/' + @get('user.id') + '/ranking_items'
  #).property('user')