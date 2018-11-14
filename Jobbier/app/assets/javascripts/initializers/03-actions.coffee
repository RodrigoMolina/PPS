window.Actions ||= {}



Actions.initToTeachWorkshopModal = ->


  $('#open-panel-chat').click ->
    $('.right-viewer').addClass 'openChatRoom'

  $('#close-chat-room').click ->
    $('.right-viewer').removeClass 'openChatRoom'




Actions.initWorkshopActions = ->


  #------------------------------------------------ STEP FINAL


  $('.step_final').on 'ifChanged', '#workshop_charge_method_transfer', (e) ->
    e.preventDefault()
    if $(this).is(':checked')
      $('#charge_method_transfer_container').show('fast')
    else
      $('#charge_method_transfer_container').hide('fast')



  #--

  $('.step_final').on 'ifChanged', '.workshop_schedule_unlimited_quota', (e) ->
    e.preventDefault()
    if $(this).is(':checked')
      $(this).closest('.row').find('.maximun_quota_container').hide('fast')
    else
      $(this).closest('.row').find('.maximun_quota_container').show('fast')

  $('.step_final').on 'ifChanged', '.workshop_schedule_always_open', (e) ->
    e.preventDefault()
    if $(this).is(':checked')
      $(this).closest('.row').find('.start_publication_container').hide('fast')
    else
      $(this).closest('.row').find('.start_publication_container').show('fast')

  $('.step_final').on 'ifChanged', '.workshop_schedule_never_close', (e) ->
    e.preventDefault()
    if $(this).is(':checked')
      $(this).closest('.row').find('.closing_of_registrations_container').hide('fast')
    else
      $(this).closest('.row').find('.closing_of_registrations_container').show('fast')



  $('.step_final').on 'click', '.add-workshop_schedule', (e) ->
    e.preventDefault()
    App.addLastToList this, '.workshop_schedules_container'
    return

  $('.step_final').on 'click', '.remove-workshop_schedule', (e) ->
    e.preventDefault()
    App.removeFromList this, '.workshop_schedule'
    return



  #--

  $(document).on 'change', '.step_final .imageloader-file-div', ->
    if $('.workshop_images_normal_container .workshop_image_normal:visible:last')[0] == $(this).closest('.workshop_image_normal')[0]
      App.addLastToList $('.add-workshop_image_normal'), '.workshop_images_normal_container'
    return

  $('.step_final').on 'click', '.add-workshop_image_normal', (e) ->
    e.preventDefault()
    App.addLastToList this, '.workshop_images_normal_container'
    return
  $('.step_final').on 'click', '.remove-workshop_image_normal', (e) ->
    e.preventDefault()
    App.removeFromList this, '.workshop_image_normal'
    if  $('.workshop_images_normal_container .workshop_image_normal:visible').length == 0
      App.addLastToList $('.add-workshop_image_normal'), '.workshop_images_normal_container'
    return



  #--



  #$(document).on 'change', '.step_final .imageloader-file-div', ->
  #  if $('.workshop_images_place_container .workshop_image_place:visible:last')[0] == $(this).closest('.workshop_image_place')[0]
  #    App.addLastToList $('.add-workshop_image_place'), '.workshop_images_place_container'
  #  return

  $('.step_final').on 'click', '.add-workshop_image_place', (e) ->
    e.preventDefault()
    App.addLastToList this, '.workshop_images_place_container'
    return
  $('.step_final').on 'click', '.remove-workshop_image_place', (e) ->
    e.preventDefault()
    App.removeFromList this, '.workshop_image_place'
    if  $('.workshop_images_place_container .workshop_image_place:visible').length == 0
      App.addLastToList $('.add-workshop_image_place'), '.workshop_images_place_container'
    return



  $('.step_final').on 'ifChecked', '#workshop_place_omitir, #workshop_place_a_domicilio, #workshop_place_other', (e) ->
    e.preventDefault()
    if $('#workshop_street').length != 0
      $('#workshop_street').val('');
      $('#workshop_street').attr('disabled', 'disabled');
      $('#workshop_number').val('');
      $('#workshop_number').attr('disabled', 'disabled');
      $('#workshop_floor').val('');
      $('#workshop_floor').attr('disabled', 'disabled');
      $('#workshop_apartment').val('');
      $('#workshop_apartment').attr('disabled', 'disabled');
    $('#address_information').hide('fast');
    return

  $('.step_final').on 'ifChecked', '#workshop_place_institucion, #workshop_place_casa, #workshop_place_aire_libre, #workshop_place_pub', (e) ->
    e.preventDefault()
    if $('#workshop_street').length != 0
      container = $('#workshop_street').closest('#address_information')
      $('#workshop_street').removeAttr('disabled');
      $('#workshop_number').removeAttr('disabled');
      $('#workshop_floor').removeAttr('disabled');
      $('#workshop_apartment').removeAttr('disabled');
      $('#address_information').show 'fast', ->
        uuid = $('#address_information').find('.map-div').data('uuid')
        $('#address_information').find('.map-div').height('300px')
        $('#address_information').find('.map-div').width('100%')
        map_id = 'map_' + uuid
        window.maps[map_id].refresh()
        window.maps[map_id].setCenter(window.maps[map_id].map.center.lat(), window.maps[map_id].map.center.lng())
        setTimeout (->
          searchMapPoint(container)
          return
        ), 1000

        return
    else
      $('#address_information').show 'fast'
    return


  $('.step_final').on 'change', '#workshop_street', (e) ->
    container = $(this).closest('#address_information')
    searchMapPoint(container)
    return

  $('.step_final').on 'change', '#workshop_number', (e) ->
    container = $(this).closest('#address_information')
    searchMapPoint(container)
    return

  $('.step_final').on 'keyup', '#workshop_street', (e) ->
    container = $(this).closest('#address_information')
    searchMapPoint(container)
    return

  $('.step_final').on 'keyup', '#workshop_number', (e) ->
    container = $(this).closest('#address_information')
    searchMapPoint(container)
    return


  #------------------------------------------------ STEP 7


  $('.step7').on 'ifChanged', '#workshop_charge_method_transfer', (e) ->
    e.preventDefault()
    if $(this).is(':checked')
      $('#charge_method_transfer_container').show('fast')
    else
      $('#charge_method_transfer_container').hide('fast')


  #------------------------------------------------ STEP 6


  $('.step6').on 'click', '.areYouShureBotton', (e) ->
    e.preventDefault()
    if $('#workshop_price').val() == ''
      label = $('.step6').find('#workshop_price').prev('.info-section-small')
      input = $('.step6').find('#workshop_price')
      if(!input.parent().hasClass('has-error'))
        label.wrap '<div class=\'has-error\'></div>'
        label.closest('.has-error').append('<span class="info-section-small">&nbsp;(No puede estar en blanco)</span>')
        input.wrap '<div class=\'has-error\'></div>'

    else
      $('#areYouShure').modal 'show'

  #------------------------------------------------ STEP 4


  $('.step4').on 'ifChanged', '.workshop_schedule_unlimited_quota', (e) ->
    e.preventDefault()
    if $(this).is(':checked')
      $(this).closest('.row').find('.maximun_quota_container').hide('fast')
    else
      $(this).closest('.row').find('.maximun_quota_container').show('fast')

  $('.step4').on 'ifChanged', '.workshop_schedule_always_open', (e) ->
    e.preventDefault()
    if $(this).is(':checked')
      $(this).closest('.row').find('.start_publication_container').hide('fast')
    else
      $(this).closest('.row').find('.start_publication_container').show('fast')

  $('.step4').on 'ifChanged', '.workshop_schedule_never_close', (e) ->
    e.preventDefault()
    if $(this).is(':checked')
      $(this).closest('.row').find('.closing_of_registrations_container').hide('fast')
    else
      $(this).closest('.row').find('.closing_of_registrations_container').show('fast')


  $('.step4').on 'click', '.add-workshop_schedule', (e) ->
    e.preventDefault()
    App.addLastToList this, '.workshop_schedules_container'
    return

  $('.step4').on 'click', '.remove-workshop_schedule', (e) ->
    e.preventDefault()
    App.removeFromList this, '.workshop_schedule'
    return



  #------------------------------------------------ STEP 3

  $(document).on 'change', '.step3 .imageloader-file-div', ->
    if $('.workshop_images_normal_container .workshop_image_normal:visible:last')[0] == $(this).closest('.workshop_image_normal')[0]
      App.addLastToList $('.add-workshop_image_normal'), '.workshop_images_normal_container'
    return

  $('.step3').on 'click', '.add-workshop_image_normal', (e) ->
    e.preventDefault()
    App.addLastToList this, '.workshop_images_normal_container'
    return
  $('.step3').on 'click', '.remove-workshop_image_normal', (e) ->
    e.preventDefault()
    App.removeFromList this, '.workshop_image_normal'
    if  $('.workshop_images_normal_container .workshop_image_normal:visible').length == 0
      App.addLastToList $('.add-workshop_image_normal'), '.workshop_images_normal_container'
    return



  #------------------------------------------------ STEP 2



  #$(document).on 'change', '.step2 .imageloader-file-div', ->
  #  if $('.workshop_images_place_container .workshop_image_place:visible:last')[0] == $(this).closest('.workshop_image_place')[0]
  #    App.addLastToList $('.add-workshop_image_place'), '.workshop_images_place_container'
  #  return

  $('.step2').on 'click', '.add-workshop_image_place', (e) ->
    e.preventDefault()
    App.addLastToList this, '.workshop_images_place_container'
    return
  $('.step2').on 'click', '.remove-workshop_image_place', (e) ->
    e.preventDefault()
    App.removeFromList this, '.workshop_image_place'
    if  $('.workshop_images_place_container .workshop_image_place:visible').length == 0
      App.addLastToList $('.add-workshop_image_place'), '.workshop_images_place_container'
    return


  $('.step2').on 'ifChecked', '#workshop_place_omitir, #workshop_place_a_domicilio, #workshop_place_other', (e) ->
    e.preventDefault()
    if $('#workshop_street').length != 0
      $('#workshop_street').val('');
      $('#workshop_street').attr('disabled', 'disabled');
      $('#workshop_number').val('');
      $('#workshop_number').attr('disabled', 'disabled');
      $('#workshop_floor').val('');
      $('#workshop_floor').attr('disabled', 'disabled');
      $('#workshop_apartment').val('');
      $('#workshop_apartment').attr('disabled', 'disabled');
    $('#address_information').hide('fast');
    return

  $('.step2').on 'ifChecked', '#workshop_place_institucion, #workshop_place_casa, #workshop_place_aire_libre, #workshop_place_pub', (e) ->
    e.preventDefault()
    if $('#workshop_street').length != 0
      container = $('#workshop_street').closest('#address_information')
      $('#workshop_street').removeAttr('disabled');
      $('#workshop_number').removeAttr('disabled');
      $('#workshop_floor').removeAttr('disabled');
      $('#workshop_apartment').removeAttr('disabled');
      $('#address_information').show 'fast', ->
        uuid = $('#address_information').find('.map-div').data('uuid')
        $('#address_information').find('.map-div').height('300px')
        $('#address_information').find('.map-div').width('100%')
        map_id = 'map_' + uuid
        window.maps[map_id].refresh()
        window.maps[map_id].setCenter(window.maps[map_id].map.center.lat(), window.maps[map_id].map.center.lng())
        setTimeout (->
          searchMapPoint(container)
          return
        ), 1000

        return
    else
      $('#address_information').show 'fast'
    return


  $('.step2').on 'change', '#workshop_street', (e) ->
    container = $(this).closest('#address_information')
    searchMapPoint(container)
    return

  $('.step2').on 'change', '#workshop_number', (e) ->
    container = $(this).closest('#address_information')
    searchMapPoint(container)
    return

  $('.step2').on 'keyup', '#workshop_street', (e) ->
    container = $(this).closest('#address_information')
    searchMapPoint(container)
    return

  $('.step2').on 'keyup', '#workshop_number', (e) ->
    container = $(this).closest('#address_information')
    searchMapPoint(container)
    return


  searchMapPoint = (container)->
    uuid = container.find('.map-div').data('uuid')
    map_id = 'map_' + uuid
    str = ''
    if $('#workshop_street').val() != ''
      str += $('#workshop_street').val() + ' '

    if $('#workshop_number').val() != ''
      str += $('#workshop_number').val() + ' '

    str += $('#workshop_country').val() + ' '
    str += $('#workshop_province').val() + ' '
    str += $('#workshop_city').val() + ' '
    
    GMaps.geocode
      address: str
      callback: (results, status) ->
        if status == 'OK'
          latlng = results[0].geometry.location
          placeMarker uuid, latlng, false
        return
    return


  placeMarker = (time, latLng, ask) ->
    map_id = 'map_' + time
    lat_id = 'map_lat_' + time
    lng_id = 'map_lng_' + time
    window.maps[map_id].removeMarkers()
    $('#'+lat_id).val(latLng.lat())
    $('#'+lng_id).val(latLng.lng())
    window.maps[map_id].addMarker
      lat: latLng.lat()
      lng: latLng.lng()
      title: 'Taller'
    window.maps[map_id].setCenter(latLng.lat(), latLng.lng())
    GMaps.geocode
      lat: latLng.lat()
      lng: latLng.lng()
      callback: (results, status) ->
        if status == 'OK'

          address_information_container = $('#'+map_id).closest('#address_information')

          if ask
            if confirm('Tomar dirección del mapa?')


              address_information_container.find('#workshop_number').val('')
              address_information_container.find('#workshop_street').val('')

              $.each results[0]['address_components'], (index, value) ->
                switch value['types'][0]
                  when 'street_number'
                    address_information_container.find('#workshop_number').val value['short_name']
                  when 'route'
                    address_information_container.find('#workshop_street').val value['short_name']

                return
    return




  # ----------------------------------- Gmaps
  initGmaps = ->

    if window.maps == undefined || $("[data-gmaps='showroom-address']").length == 0
      window.maps = {}

    handleLocationError = (browserHasGeolocation) ->
      if browserHasGeolocation
        alert 'Error: The Geolocation service failed.'
      else
        alert 'Error: Your browser doesn\'t support geolocation.'
      return


     setTimeout (->
      console.log 'whaitforit'

      $("[data-gmaps='showroom-address']").each ->
        $(this).attr('data-gmaps', 'showroom-address-init')

        #set ids
        time = (new Date).getTime()
        container_id = 'map_container_' + time
        map_id = 'map_' + time
        lat_id = 'map_lat_' + time
        lng_id = 'map_lng_' + time

        #set structure and ids
        $(this).attr('id', container_id)
        $(this).prepend('<div id="'+map_id+'" class="map-div" data-uuid="'+time+'" style="'+$(this).attr('style')+'"></div>')
        $(this).removeAttr('style')
        map_lat = $(this).find('.map_lat')
        map_lng = $(this).find('.map_lng')
        map_lat.attr('id', lat_id)
        map_lng.attr('id', lng_id)

        if map_lat.val() != '' && map_lng.val() != ''
          lat = map_lat.val()
          lng = map_lng.val()
          zoom = 15
        else
          lat = -34.91063278150718
          lng = -57.95365333557129
          zoom = 12

        map = new GMaps(
            div: '#' + map_id
            lat: lat
            lng: lng
            click: (e) ->
              placeMarker time, e.latLng, true
              return
          )
        window.maps[map_id] = map
        window.maps[map_id].setZoom(zoom);
        if map_lat.val() == '' && map_lng.val() == ''



          if navigator.geolocation
            navigator.geolocation.getCurrentPosition ((position) ->
              lat = position.coords.latitude
              lng = position.coords.longitude
              window.maps[map_id].setCenter(position.coords.latitude, position.coords.longitude);
              window.maps[map_id].setZoom(15);
            ), ->
              handleLocationError true
              return
          else
            # Browser doesn't support Geolocation
            handleLocationError false



        if map_lat.val() != '' && map_lng.val() != ''
          window.maps[map_id].addMarker
            lat: lat
            lng: lng
            title: 'Showroom'
        return



      return
    ), 500



    return
  # ----------------------------------- Gmaps


  initGmaps()




Actions.initWorkshopMap = ->

  $(document).off 'click', '#explorar_workshops'

  $('#filter_form .j-input').each ->
    this.onkeypress = (e) ->
      if !e
        e = window.event
      keyCode = e.keyCode or e.which
      if keyCode == 13 or keyCode == '13'
        if $('#explorar_workshops').length != 0
          $('#explorar_workshops').trigger('click')
        else
          $('#explorar_workshops_index').trigger('click')
      return

  $(document).on 'click', '#explorar_workshops', (e) ->
    e.preventDefault()


    terminos_busqueda = $('#filter_query').val()+'_'+$('#filter_label').val()+'_'+$('#filter_workshop_category_id option:selected').text()

    #alert(terminos_busqueda);
    ga('send', 'event', 'buscador', 'click', terminos_busqueda);







    handleLocationError = (browserHasGeolocation) ->
      $('#filter_latitude').val undefined
      $('#filter_longitude').val undefined
      $('#filter_center_latitude').val undefined
      $('#filter_center_longitude').val undefined
      $('#filter_geo_ok').val false
      if browserHasGeolocation
        alert('Para mejorar su experiencia, por favor active la configuración de geolocalización')
        $('#filter_form').submit()
      else
        alert('Error: Tu navegador no soporta Geolocalización')
        $('#filter_form').submit()
      return

    if($('#filter_label').val() == 'Mi Ubicación') && ($('#filter_label_old').val() != 'Mi Ubicación')

      if navigator.geolocation
        navigator.geolocation.getCurrentPosition(((position) ->
          lat = undefined
          lng = undefined
          lat = position.coords.latitude
          lng = position.coords.longitude
          $('#filter_latitude').val lat
          $('#filter_longitude').val lng
          $('#filter_center_latitude').val lat
          $('#filter_center_longitude').val lng
          $('#filter_geo_ok').val true
          $('#filter_form').submit()
          return
        ), (e) ->
          handleLocationError true
          return
        )
        timeout: 5000

      else
        # Browser doesn't support Geolocation
        handleLocationError false

    else
      $('#filter_form').submit()



  $(document).off 'click', '#blank_label_search'
  $(document).on 'click', '#blank_label_search', (e) ->
    e.preventDefault()
    $('#filter_label').val('')
    $('#filter_latitude').val('')
    $('#filter_longitude').val('')
    $('#filter_norte').val('')
    $('#filter_sur').val('')
    $('#filter_este').val('')
    $('#filter_oeste').val('')
    $('#filter_form').submit()

  $(document).off 'click', '#blank_query_search'
  $(document).on 'click', '#blank_query_search', (e) ->
    e.preventDefault()
    $('#filter_query').val('')
    $('#filter_form').submit()

  $(document).off 'click', '#blank_workshop_category_search'
  $(document).on 'click', '#blank_workshop_category_search', (e) ->
    e.preventDefault()
    $('#filter_workshop_category_id').val('')
    $('#filter_form').submit()



  $(document).off 'click', '#blank_query_and_workshop_category_search'
  $(document).on 'click', '#blank_query_and_workshop_category_search', (e) ->
    e.preventDefault()
    $('#filter_query').val('')
    $('#filter_workshop_category_id').val('')
    $('#filter_form').submit()



  $(document).off 'click', '#blank_label_and_workshop_category_search'
  $(document).on 'click', '#blank_query_and_workshop_category_search', (e) ->
    e.preventDefault()
    $('#filter_label').val('')
    $('#filter_latitude').val('')
    $('#filter_longitude').val('')
    $('#filter_norte').val('')
    $('#filter_sur').val('')
    $('#filter_este').val('')
    $('#filter_oeste').val('')
    $('#filter_workshop_category_id').val('')
    $('#filter_form').submit()


  $(document).off 'click', '#blank_label_and_query_search'
  $(document).on 'click', '#blank_label_and_query_search', (e) ->
    e.preventDefault()
    $('#filter_label').val('')
    $('#filter_latitude').val('')
    $('#filter_longitude').val('')
    $('#filter_norte').val('')
    $('#filter_sur').val('')
    $('#filter_este').val('')
    $('#filter_oeste').val('')
    $('#filter_query').val('')
    $('#filter_form').submit()















  $(document).off 'click', '#explorar_workshops_index'
  $(document).on 'click', '#explorar_workshops_index', (e) ->
    e.preventDefault()


    #alert('lupa-buscar-'+$('#filter_label').val());
    ga('send', 'event', 'Home', 'click', 'lupa-buscar-'+$('#filter_label').val());



    handleLocationError = (browserHasGeolocation) ->
      $('#filter_latitude').val undefined
      $('#filter_longitude').val undefined
      $('#filter_center_latitude').val undefined
      $('#filter_center_longitude').val undefined
      $('#filter_geo_ok').val false
      if browserHasGeolocation
        alert('Para mejorar su experiencia, por favor active la configuración de geolocalización')
        $('#filter_form').submit()
      else
        alert('Error: Tu navegador no soporta Geolocalización')
        $('#filter_form').submit()
      return


    if($('#filter_label').val() == 'Mi Ubicación')# && ($('#filter_query').val() == '')

      if navigator.geolocation
        navigator.geolocation.getCurrentPosition(((position) ->
          lat = undefined
          lng = undefined
          lat = position.coords.latitude
          lng = position.coords.longitude
          $('#filter_latitude').val lat
          $('#filter_longitude').val lng
          $('#filter_center_latitude').val lat
          $('#filter_center_longitude').val lng
          $('#filter_geo_ok').val true
          $('#filter_form').submit()
          return
        ), (e) ->
          handleLocationError true
          return
        )
        timeout: 5000

      else
        # Browser doesn't support Geolocation
        handleLocationError false

    else
      $('#filter_form').submit()


  first_load = true
  timeout = null
  map_id = 'list_map'
  filter_latitude = $('#filter_latitude')
  filter_longitude = $('#filter_longitude')


  initWorkshopsMapGmaps = ->

    $(document).on 'focus', '#filter_label', (e) ->
      if($('#filter_label').val() == 'Mi Ubicación')
        $('#filter_label').val('')
        $('#filter_label').data('clicked-place', '1')
      return
    $(document).on 'blur', '#filter_label', (e) ->
      if(($('#filter_label').data('clicked-place') == '1') && ($('#filter_label').val() == ''))
        $('#filter_label').val('Mi Ubicación')
        $('#filter_label').data('clicked-place', '0')
        #$('#filter_form').submit()
      return

    window.maps = {}
    window.markers = {}
    window.infos = {}
    window.pointer = undefined


    map = $("[data-gmaps='workshops-map']")

    if map.length != 0
      map.attr('data-gmaps', 'workshops-map-init')


      #set structure and ids
      map.prepend('<div id="'+map_id+'" style="'+map.attr('style')+'"></div>')
      #map.removeAttr('style')

      lat = parseFloat($('#filter_center_latitude').val())
      lng = parseFloat($('#filter_center_longitude').val())
      zoom = parseInt($('#filter_zoom').val())

      gmap = new GMaps(
          div: '#' + map_id
          lat: lat
          lng: lng
          zoom: zoom
          #click: (e) ->
            #$('#filter_latitude').val(e.latLng.lat())
            #$('#filter_longitude').val(e.latLng.lng())
            #$('#filter_form').submit()
            #return
        )


      google.maps.event.addListener gmap.map, 'zoom_changed', () ->
        $('#filter_zoom').val(window.maps[map_id].getZoom())
        return

      google.maps.event.addListener gmap.map, 'idle', () ->
        bounds = window.maps[map_id].getBounds()
        ne = bounds.getNorthEast()
        sw = bounds.getSouthWest()
        este = ne.lng()
        oeste = sw.lng()
        norte = ne.lat()
        sur = sw.lat()
        $('#filter_este').val(este)
        $('#filter_oeste').val(oeste)
        $('#filter_norte').val(norte)
        $('#filter_sur').val(sur)
        $('#filter_center_latitude').val(window.maps[map_id].getCenter().lat())
        $('#filter_center_longitude').val(window.maps[map_id].getCenter().lng())

        if first_load
          first_load = false
          $('#filter_form').submit()
        else
          if timeout
            clearTimeout timeout
            timeout = null
          timeout = setTimeout((->
            $('#filter_form').submit()
            return
          ), 1000)
        return


      window.maps[map_id] = gmap
      window.markers[map_id] = {}
      window.infos[map_id] = new google.maps.InfoWindow({disableAutoPan: true})



  initWorkshopsMapGmaps()
