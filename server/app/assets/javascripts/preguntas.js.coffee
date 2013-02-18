# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  # Open comentario form if needed
  hash=window.location.hash
  if hash == '#new_comentario'
    $('#agregar-comentario').hide()
    $('#new_comentario').show()
  
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

  # Formularios comentarios
  $('#agregar-comentario').click ->
    $('#agregar-comentario').hide()
    $('#new_comentario').show()
    false
