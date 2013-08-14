VoluntaryOnEmberjs.Adapter = DS.RESTAdapter.extend
  findQuery: (store, type, query, recordArray) ->
    root = @rootForType(type)
    url = @buildURL(root)
    
    if type.toString().match('ListItem')
      topic = query['topic']
      url = ''
      
      if type.toString().match('UserListItem')
        url = 'users/' + query['user_id'] + '/'
        delete query['user_id']
        
      url += 'topics/' + topic + '.json'
        
      delete query['topic']
    
      camelCaseAttributes = { 'thingType': 'thing_type', 'negativeAdjective': 'negative_adjective' }
      
      $.each camelCaseAttributes, (camelCaseAttribute, attribute) =>
        query[attribute] = query[camelCaseAttribute]
        delete query[camelCaseAttribute]
        
    adapter = this
    
    @ajax(url, 'GET',
      data: query
    ).then (json) ->
      Ember.run adapter, ->
        @didFindQuery store, type, json, recordArray
        
  createRecord: (store, type, record) ->
    root = @rootForType(type)
    adapter = this
    
    data = {}
    data[root] = @serialize(record,
      includeId: true
    )
    root = @rootForType(type)
    
    url = if record.get("url") then record.get("url") else @buildURL(root)
    
    @ajax(url, "POST",
      data: data
    ).then ((json) ->
      Ember.run adapter, "didCreateRecord", store, type, record, json
    ), (xhr) ->
      adapter.didError store, type, record, xhr
      throw xhr
      
VoluntaryOnEmberjs.Adapter.configure "VoluntaryOnEmberjs.List",
  alias: "list"

VoluntaryOnEmberjs.Adapter.configure "VoluntaryOnEmberjs.ListItem",
  alias: "list_item"

VoluntaryOnEmberjs.Adapter.configure "VoluntaryOnEmberjs.UserListItem",
  alias: "user_list_item"
     
VoluntaryOnEmberjs.Adapter.configure "VoluntaryOnEmberjs.Thing",
  alias: "thing"
     
VoluntaryOnEmberjs.Adapter.configure "VoluntaryOnEmberjs.Movie",
  alias: "movie" 