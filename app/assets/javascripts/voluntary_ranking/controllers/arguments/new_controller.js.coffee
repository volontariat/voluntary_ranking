Volontariat.ArgumentsNewController = Ember.ObjectController.extend
  topicName: '', value: ''
  
  actions:
    
    create: ->
      # TODO: replace manual ajax logic by createRecord usage if the thingId can be passed
      #argument = @store.createRecord('argument', topicName: @get('topicName'), thingId: $('#thing_id').val(), value: @get('value'))
      #argument.save()
      $.post('/api/v1/arguments', { argument: { topic_name: @get('topicName'), thing_name: $('#thing_name').val(), value: @get('value') } }).success =>
        @send "closeModal"
        @transitionToRoute('no_data')
        @transitionToRoute('arguments.index', $('#thing_name').val(), 1)
    
    close: ->
      @send "closeModal"