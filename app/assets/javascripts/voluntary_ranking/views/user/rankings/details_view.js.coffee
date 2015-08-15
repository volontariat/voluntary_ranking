Volontariat.UserRankingsDetailsView = Ember.View.extend
  didInsertElement: ->
    $('input[data-autocomplete]').each (k, v) ->
      $(v).autocomplete
        source: $(this).attr('data-autocomplete'),
        select: (event, ui) ->
          $(this).val(ui.item.value)
          false