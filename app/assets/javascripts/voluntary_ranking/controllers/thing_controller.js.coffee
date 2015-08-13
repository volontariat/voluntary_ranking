Volontariat.ThingController = Ember.Controller.extend
  name: ''
  
  actions:
    
    compare: ->
      @transitionToRoute('compare_things', @get('name'), @get('otherThingName'))
    
    close: ->
      @send "closeModal"