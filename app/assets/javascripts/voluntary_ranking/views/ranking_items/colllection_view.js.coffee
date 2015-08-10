Volontariat.RankingItemsCollectionView = Ember.View.extend
  # {{view Ember.Select contentBinding="Volontariat.Ranking.thingTypes" valueBinding="controller.thingType" class="thing_type" }}
  templateName: 'ranking_items/_collection'
  
  didInsertElement: ->
    first_position = $('#ranking li:first').data('position')
    last_position = $('#ranking li:last').data('position')

    @$( '#ranking' ).sortable
      start: (event, ui) =>
        first_position = $('#ranking li:first').data('position')
        last_position = $('#ranking li:last').data('position')
        
      update: (event, ui) =>
        source_item = $(ui.item).closest('li')
        
        Volontariat.current_position = first_position
        previous_element = null
        
        $.each $('#ranking li'), (index, element) ->
          Volontariat.__container__.lookup('store:main').find('user_ranking_item', $(element).data('id')).then (user_ranking_item) ->
            $(element).data('position', Volontariat.current_position)  
            user_ranking_item.set('position', Volontariat.current_position)
            
            if $(element).data('id') == $(source_item).data('id')
              $.post '/api/v1/user_ranking_items/' + $(element).data('id') + '/move', { _method: 'put', position: Volontariat.current_position }
            
            previous_element = $(element)
            Volontariat.current_position += 1