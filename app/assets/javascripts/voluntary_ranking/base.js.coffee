Ember.TextField.reopen attributeBindings: [
  'data-autocomplete', 'data-jquery-autocomplete'
]

document.body.addEventListener 'DOMNodeInserted', ((event) ->
  $('input[data-jquery-autocomplete]').each (k, v) ->
    $(v).autocomplete
      source: $(this).data('jquery-autocomplete'),
      select: (event, ui) ->
        $(this).val(ui.item.value)
        false
)