Volontariat.Argument = DS.Model.extend
  #topic: DS.belongsTo('topic')
  topicId: DS.attr('number')
  topicName: DS.attr('string')
  thing: DS.belongsTo('thing')
  thingId: DS.attr('number')
  value: DS.attr('string')