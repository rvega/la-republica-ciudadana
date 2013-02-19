# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  hash=window.location.hash

  # Abrir form comentario si se necesita
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
  
  # Anchor links scroll offset
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

  # VOTOS
  vote = (value, id, type) ->
    ctnr = '#votos_'+id
    $.ajax(
      url: '/votos.json',
      type: 'POST',
      data:{
        voto:{
          votable_type: type,
          votable_id: id,
          value: value
        }
      }
      success: (data, status, xhr) ->
        $(ctnr + ' .votos-total').html(data.votos_total)
        $(ctnr + ' .votos-mas').html(data.votos_mas)
        $(ctnr + ' .votos-menos').html('-'+data.votos_menos)
      ,
      error: (xhr, status, error) ->
        template = """    
          <div class="alert alert-error">
          <a href="#" class="close" data-dismiss="alert">&times;</a>
            {{msg}}
          </div>
        """
        msg = JSON.parse(xhr.responseText).usuario_id
        html = template.replace('{{msg}}', msg)
        $(ctnr).append html
    )

  $('.votos .menos').click (event) ->
    element = $(event.target).parent('a')
    vote -1, element.attr('data-votable-id'), element.attr('data-votable-type')
    false

  $('.votos .mas').click (event) ->
    element = $(event.target).parent('a')
    vote 1, element.attr('data-votable-id'), element.attr('data-votable-type')
    false

