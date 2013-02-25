# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  hash=window.location.hash

  hideButtons = ->
    $('.agregar-comentario').hide()
    $('.btn-editar-comentario').hide()
    $('.btn-editar-pregunta').hide()
    $('.respuesta-edit-btn').hide()


  # Abrir form comentario si se necesita
  unless hash.indexOf('form-comentario')==-1
    partialId =  hash.substring( hash.indexOf('-') )
    idBtn = "agregar#{partialId}"
    idForm = "form#{partialId}"
    $('#'+idForm).show()
    
    # Si vamos a mostrar el form, es porque hay errores de validación, 
    # evite que se muestren otros forms al mismo tiempo:
    hideButtons()

  # Formularios comentarios
  $('.btn-editar-comentario, .agregar-comentario').click (event) ->
    hideButtons()
    btn = $(event.target)
    btn = btn.parent('a') if btn.get(0).tagName!='A'
    form = $('#'+btn.attr('data-form'))
    form.show()
  
    if btn.hasClass('btn-editar-comentario')
      cuerpo = btn.parents('p.cuerpo-comentario').hide()

    false

  # Abrir form respuesta si se necesita
  unless hash.indexOf('edit_respuesta')==-1
    partialId =  hash.substring( hash.indexOf('_') + 1 )
    idCuerpo = '#' + partialId + " .hideme"
    idBtn = '#' + partialId + " .respuesta-edit-btn"
    idForm = '#' + partialId + " .respuesta-edit-form"
    hideButtons()
    $(idCuerpo).hide()
    $(idForm).show()
    
    
  # Formularios respuestas
  $('.respuesta-edit-btn').click (event) ->
    btn = $(event.target)
    id = btn.parents('.indent-1').attr('id')
    $('#'+id+' .hideme').hide()
    $('#'+id+' .respuesta-edit-form').show()
    hideButtons()
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
  delete_voto = (id, type) ->
    ctnr = '#votos-'+ type.toLowerCase() + '-' + id
    $.ajax(
      url: '/votos.json',
      type: 'DELETE',
      data:{
        voto:{
          votable_type: type,
          votable_id: id,
        }
      },
      success: (data, status, xhr) ->
        $(ctnr + ' .votos-total').html(data.votos_total)
        $(ctnr + ' .votos-mas').html(data.votos_mas)
        $(ctnr + ' .votos-menos').html('-'+data.votos_menos)

        $(ctnr + ' .remover').hide()
        $(ctnr + ' .mas').show()
        $(ctnr + ' .menos').show()
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
        setTimeout ->
          $(ctnr+' .alert').alert('close')
        , 3000
    )

  vote = (value, id, type) ->
    ctnr = '#votos-'+ type.toLowerCase() + '-' + id
    $.ajax(
      url: '/votos.json',
      type: 'POST',
      data:{
        voto:{
          votable_type: type,
          votable_id: id,
          value: value
        }
      },
      success: (data, status, xhr) ->
        $(ctnr + ' .votos-total').html(data.votos_total)
        $(ctnr + ' .votos-mas').html(data.votos_mas)
        $(ctnr + ' .votos-menos').html('-'+data.votos_menos)

        $(ctnr + ' .remover').show()
        $(ctnr + ' .mas').hide()
        $(ctnr + ' .menos').hide()
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
        setTimeout ->
          $(ctnr+' .alert').alert('close')
        , 3000
    )

  $('.votos .menos').click (event) ->
    element = $(event.target).parent('a')
    vote -1, element.attr('data-votable-id'), element.attr('data-votable-type')
    false

  $('.votos .mas').click (event) ->
    element = $(event.target).parent('a')
    vote 1, element.attr('data-votable-id'), element.attr('data-votable-type')
    false

  $('.votos .remover').click (event) ->
    element = $(event.target).parent('a')
    delete_voto element.attr('data-votable-id'), element.attr('data-votable-type')
    false

