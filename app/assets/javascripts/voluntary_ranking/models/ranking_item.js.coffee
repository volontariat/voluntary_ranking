VoluntaryOnEmberjs.RankingItem = DS.Model.extend
  ranking: DS.belongsTo('ranking')
  #thing: DS.belongsTo('thing', { polymorphic: true })
  thingType: DS.attr('string')
  thingName: DS.attr('string')
  position: DS.attr('number')
  
  best: DS.attr('boolean')
  stars: DS.attr('number')
  topic: DS.attr('string')
  scope: DS.attr('string')