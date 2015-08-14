Volontariat.RankingItemsCollectionView = Ember.View.extend
  templateName: 'ranking_items/_collection'
  
  didInsertElement: ->
    first_position = $('#ranking li:first').data('position')
    last_position = $('#ranking li:last').data('position')

    @$( '#ranking' ).sortable
      handle: '.ranking_item_sortable'
      start: (event, ui) =>
        first_position = $('#ranking li:first').data('position')
        last_position = $('#ranking li:last').data('position')
        console.log 'start:' + first_position + ' - ' + last_position
        
      update: (event, ui) =>
        source_item = $(ui.item).closest('li')
        console.log 'update:' + $(source_item).data('position')
        Volontariat.current_position = first_position
        
        $.each $('#ranking li'), (index, element) ->
          $(element).data('position', Volontariat.current_position)  
          $(element).find('.ranking_item_position').text(Volontariat.current_position)
          
          if $(element).data('id') == $(source_item).data('id')
            $.post '/api/v1/user_ranking_items/' + $(element).data('id') + '/move', { _method: 'put', position: Volontariat.current_position }
          
          Volontariat.current_position += 1