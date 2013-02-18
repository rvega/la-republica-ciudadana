# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  hash=window.location.hash

  # Open comentario form if needed
  unless hash.indexOf('form-comentario')==-1
    partialId =  hash.substring( hash.indexOf('-') )
    idBtn = "agregar#{partialId}"
    idForm = "form#{partialId}"
    $('#'+idBtn).hide()
    $('#'+idForm).show()
    
    # Si vamos a mostrar el form, es porque hay errores de validación, 
    # evite que se muestren otros forms al mismo tiempo:
    $('.agregar-comentario').hide()
    
  # Formularios comentarios
  $('.agregar-comentario').click (event) ->
    $('.agregar-comentario').hide()
    btn = $(event.target)
    form = $('#'+btn.attr('data-form'))
    form.show()
    false
  
  # Anchor lnks scroll offset
  if hash
    setTimeout ->
      y = $(hash).offset().top - 50
      $('body').scrollTop(y)
    ,100

  #Tooltips
  $('[data-toggle=tooltip]').tooltip placement:'right'

  # WYSIWYG
  $('#formato').click ->
    $('#formato').hide()
    $('.wysiwyg').wysihtml5
      'font-styles':false,
      image:false,
      locale:'es-AR',
      color:true,
    false

