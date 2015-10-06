Volontariat.StarsHtmlHelper = Ember.Helper.helper((params) ->
  value = params[0]
  text = ''
  
  if value == 5
    text += '<span class="active"></span>'
  else
    text += '<span></span>'
 
  if value >= 4
    text += '<span class="active"></span>'
  else
    text += '<span></span>' 

  if value >= 3
    text += '<span class="active"></span>'
  else
    text += '<span></span>' 
    
  if value >= 2
    text += '<span class="active"></span>'
  else
    text += '<span></span>'     
    
  if value >= 1
    text += '<span class="active"></span>'
  else
    text += '<span></span>'   
    
  new (Ember.Handlebars.SafeString)(text)
)