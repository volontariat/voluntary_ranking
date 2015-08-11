Volontariat.ThingController = Ember.ObjectController.extend
  otherThingName: ''
  
  actions:
    
    compare: ->
      @transitionToRoute('compare_things', @get('name'), @get('otherThingName'))
    
    close: ->
      @send "closeModal"