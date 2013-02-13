# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
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
    $('#formulario-comentario').show()
    false
