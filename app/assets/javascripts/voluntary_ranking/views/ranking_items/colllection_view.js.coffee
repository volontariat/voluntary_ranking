VoluntaryOnEmberjs.RankingItemsCollectionView = Ember.View.extend
  # {{view Ember.Select contentBinding="VoluntaryOnEmberjs.Ranking.thingTypes" valueBinding="controller.thingType" class="thing_type" }}
  templateName: 'voluntary_ranking/templates/ranking_items/_collection'
  
  didInsertElement: ->
    #@modelChanged()
    first_position = $('#ranking li:first').data('position')
    last_position = $('#ranking li:last').data('position')

    @$( '#ranking' ).sortable
      start: (event, ui) =>
        first_position = $('#ranking li:first').data('position')
        last_position = $('#ranking li:last').data('position')
        
      update: (event, ui) =>
        source_item = $(ui.item).closest('li')
        
        VoluntaryOnEmberjs.current_position = first_position
        previous_element = null
        
        $.each $('#ranking li'), (index, element) ->
          VoluntaryOnEmberjs.__container__.lookup('store:main').find('user_ranking_item', $(element).data('id')).then (user_ranking_item) ->
            $(element).data('position', VoluntaryOnEmberjs.current_position)  
            user_ranking_item.set('position', VoluntaryOnEmberjs.current_position)
            
            user_ranking_item.save() if $(element).data('id') == $(source_item).data('id')
            
            previous_element = $(element)
            VoluntaryOnEmberjs.current_position += 1
          
    #@$( '#ranking' ).disableSelection()