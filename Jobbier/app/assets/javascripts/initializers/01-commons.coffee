window.App ||= {}

App.flash_snackbar_render = (flashMessages) ->
  $('#snackbar-container > span, #snackbar-container > div').remove()
  $.each flashMessages, (key, value) ->
    style = ''
    switch key
      when 'success'
        style = 'callout callout-success'
      when 'danger'
        style = 'callout callout-danger'
      when 'error'
        style = 'callout callout-danger'
      else
        style = 'callout'
        break
    $.snackbar
      content: value
      style: style
      timeout: 10000
    return
  return

App.initSnackbar = ->
  if $('#snackbar-container').length == 0
    $("body").append("<div id=snackbar-container/>")
  if $('.snackbar-message').length > 0
    $('.snackbar-message').snackbar 'show'
    $('#snackbar-container-l > span, #snackbar-container-l > div').remove()


# Inicializa los modals con ajax
App.initModals = () ->
  links = $('[data-behavior~=ajax-modal]')
  links.off 'click'
  links.on 'click', (e)->
    e.preventDefault()
    e.stopPropagation()
    App.modalClick(this)

App.modalClick = (button) ->
  $('.select2-drop').each ->
    $(this).select2 'close'
    return
  $.getScript(button.getAttribute('href'))
  return


App.initInfinitePagination = () ->
  if $('#paginate_container.infinite ul.pagination').length
    scrollPosition = $(window).scrollTop()
    sectionHeight = $(window).height()
    scrollHeight = $(document).height()
    tot = (scrollPosition + sectionHeight)
    if(tot >= scrollHeight)
       url = $('#paginate_container.infinite .next_page > a').attr('href')
       $('#paginate_container.infinite').addClass('show').html '<i class="fa fa-circle-o-notch fa-spin fa-3x"></i>'
       $.getScript(url)
       return

    $(window).off('scroll')
    $(window).scroll ->
      url = $('#paginate_container.infinite .next_page > a').attr('href')
      if url and $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('#paginate_container.infinite').addClass('show').html '<i class="fa fa-circle-o-notch fa-spin fa-3x"></i>'
        return $.getScript(url)
      return



App.addToBeforeList = (button, container) ->
  time = (new Date).getTime()
  regexp = new RegExp($(button).data('id'), 'g')
  $(container).before $(button).data('fields').replace(regexp, time)
  App.init()
  return
App.addToList = (button, container) ->
  time = (new Date).getTime()
  regexp = new RegExp($(button).data('id'), 'g')
  $(container).prepend $(button).data('fields').replace(regexp, time)
  App.init()
  return
App.addLastToList = (button, container) ->
  time = (new Date).getTime()
  regexp = new RegExp($(button).data('id'), 'g')
  $(container).append $(button).data('fields').replace(regexp, time)
  App.init()
  return

App.removeFromList = (button, item) ->
  $(button).prev('input[type=hidden]').val '1'
  $(button).closest(item).hide()
  return

App.moveUp = (button, item) ->
  section = $(button.closest(item))
  section.insertBefore(section.prev(item))
  return

App.moveDown = (button, item) ->
  section = $(button.closest(item))
  section.insertAfter(section.next(item))
  return




App.init = ->

  # Snackbar
  App.initSnackbar()

  # Ajax Modals
  App.initModals()

  # Infinite Pagination
  App.initInfinitePagination()

  # Sidebar
  $('[data-controlsidebar]').on 'click', ->
    change_layout $(this).data('controlsidebar')
    slide = !AdminLTE.options.controlSidebarOptions.slide
    AdminLTE.options.controlSidebarOptions.slide = slide
    if !slide
      $('.control-sidebar').removeClass 'control-sidebar-open'
    return

  $("[data-toggle='toggle-filter']").off('click')
  $("[data-toggle='toggle-filter']").on 'click', ->
    box = $(this).data('target')
    $(box).toggleClass('visible')

  # Select2
  $("select:not(.no-select2)").normalSelect()
  $("input.select_ajax, select.select_ajax").each ->
    $(this).ajaxSelect()
  $("input.select_ajax_geo, select.select_ajax_geo").each ->
    $(this).ajaxSelectGeo()

  # Datepickers
  $('.datepicker').datetimepicker({format: 'DD/MM/YYYY', locale: 'es'})
  $('.datetimepicker').datetimepicker({format: 'DD/MM/YYYY HH:mm', locale: 'es'})
  $('.timepicker').datetimepicker({format: 'HH:mm', locale: 'es'})


  if $('#map-container').length != 0
    lat = $('#map-container').data('lat')
    lng = $('#map-container').data('lng')

    gmap_url = GMaps.staticMapURL(
      size: [
        760
        300
      ]
      lat: lat
      lng: lng
      zoom: 16
      markers: [
        {
          lat: lat
          lng: lng
          icon: 'https://www.jobbier.com/perm_assets/images/marker.png'
        }
      ])

    $('#map-container').html('<img class="center-block img-responsive" src="'+gmap_url+'">')



  # Texto enriquecido
  $('.wysiwyg').each ->
    @mooEditable actions: 'bold italic underline strikethrough | forecolor | formatBlock justifyleft justifyright justifycenter justifyfull | insertunorderedlist insertorderedlist | tableadd tableedit tablerowadd tablerowedit tablerowspan tablerowsplit tablerowdelete tablecoladd tablecoledit tablecolspan tablecolsplit tablecoldelete | undo redo removeformat | createlink unlink | urlimage image | toggleview'
    return

  #Checkboxes y radio
  $('input.icheck').iCheck({checkboxClass: 'icheckbox_square-purple', radioClass: 'iradio_square-purple'})


  # Editor codigo
  ace.config.set 'workerPath', '/perm_assets/javascripts'
  ace.config.set 'themePath', '/perm_assets/javascripts'
  ace.config.set 'modePath', '/perm_assets/javascripts'

  $('textarea[data-editor="ace"]').each ->
    textarea = $(this)
    textarea.hide()
    textarea.removeAttr('data-editor')
    ace_editor = $('<div id="ace_editor"></div><div class="scrollmargin"></div>').insertBefore(textarea)
    editor = ace.edit(ace_editor[0])
    editor.setTheme 'ace/theme/monokai'
    editor.setOptions
      tabSize: 2
      maxLines: Infinity
      minLines: 1
      autoScrollEditorIntoView: true
    editor.renderer.setScrollMargin 10, 10, 10, 10
    editor.getSession().setMode 'ace/mode/html'
    editor.getSession().setValue textarea.val()
    editor.getSession().on 'change', ->
      textarea.val editor.getSession().getValue()
      return
    return


  # rango valor
  $('.slider-range').each ->
    range_ui = $(this).find('.slider-range-ui:not(.active)')
    if(range_ui.length != 0)
      min = parseInt(range_ui.data('min'))
      max = parseInt(range_ui.data('max'))
      range_min = $(this).find('.slider-range-min')
      range_max = $(this).find('.slider-range-max')
      range_label = $(this).find('.slider-range-label')
      range_ui.slider
        range: true
        min: 1
        max: 100
        values: [
          min
          max
        ]
        slide: (event, ui) ->
          range_label.html ui.values[0] + ' - ' + ui.values[1]
          range_min.val ui.values[0]
          range_max.val ui.values[1]
          return

      range_ui.addClass 'active'
      range_label.html min + ' - ' + max
    return


  # Preload imagenes en input files
  $('.imageloader-file').on 'change', ->
    container = $(this).closest('.imageloader-container')
    img = container.find('.imageloader-img')
    if @files and @files[0]
      reader = new FileReader

      reader.onload = (e) ->
        img.attr 'src', e.target.result
        return

      reader.readAsDataURL @files[0]
    return

    # Preload imagenes en input files
  $('.imageloader-file-div').on 'change', ->
    container = $(this).closest('.imageloader-container')
    img = container.find('.imageloader-img')
    if @files and @files[0]
      reader = new FileReader

      reader.onload = (e) ->
        img.css "background-image", 'url("'+e.target.result+'")'

        i = new Image
        i.src = e.target.result
        i.onload = ->
          if i.naturalWidth > i.naturalHeight
            img.removeClass('high').addClass 'wide'
          else
            img.removeClass('wide').addClass 'high'
          return

        return

      reader.readAsDataURL @files[0]
    return



  # Tooltip
  $("[data-toggle=tooltip]").tooltip();


  # Al hacer clicl en un por ejemplo calendar, tambien abra el datepicker*/
  $('.input-group-addon.extend-input').on 'click', ->
    $(this).closest('div').find('input').trigger 'focus'
    return

  # Reactivo eventos de AdminLTE porque se pierden con turbolinks
  $.AdminLTE.layout.activate()
  $.AdminLTE.tree('.sidebar')

  $('.sidebar li.active').closest('.treeview').addClass('active')

  # tablas con link
  $('.tr-link td:not(.operations)').unbind 'click'
  $('.tr-link td:not(.operations)').on 'click', ->
    $(this).parent().find('.tr-link-a')[0].click()

  return


App.initActions = ->
  Animations.initAll()
  SweetAlert.initConfig()
  # Actions de forms
  Actions.initWorkshopActions()
  Actions.initWorkshopMap()
  return


#----------------------------- (RAILS  >= 5)
$(document).on "turbolinks:load", ->

#----------------------------- (RAILS  < 5)
#$(document).ready ->
  App.init()
  App.initActions()



# Dispara msj de flash desde js
# Ej: $(document).trigger('flash:send', {"danger":"Hola"});
$(document).on 'flash:send', (e, flashMessages) ->
  $('#snackbar-container > div').remove()
  App.flash_snackbar_render flashMessages
  return
