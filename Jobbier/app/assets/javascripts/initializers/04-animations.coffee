window.Animations ||= {}

$ ->

  Animations.initAll = ->

    $('#options-button').on 'click', (e) ->
      e.preventDefault()
      $('.options-menu, #gradient-menu').toggleClass 'open-map'
      return

    $('#map-button').on 'click', (e) ->
      e.preventDefault()
      $('#map-filter-workshop').toggleClass 'open-map'
      window.maps['list_map'].refresh()
      return

    #Para safar escondo el footer en register page
    if window.location.href == 'http://localhost:3000/users/sign_up'
      $('#footer').hide()

  #slide
    $('.left-arrow').on 'click', (e) ->
      $(this).closest('.slide-card-section').stop().animate({scrollLeft: '-=200px'}, 800)
    $('.right-arrow').on 'click', (e) ->
      $(this).closest('.slide-card-section').stop().animate({scrollLeft: '+=200px'}, 800)

  Animations.onResize = ->
  #Modal control panel
    closeModalSection = $('#close-modal-section')

    teacherInfoSectionOnModal = $('#teacher-info-section-on-custom-modal')

    fixPanel = ->
      panelEntity = $('#panel-entity')
      panelWorkshopInfo = $('#panel-workshop-info')
      chatContButton = $('#cont-chat-button')
      panelEntity.height window.innerHeight-panelWorkshopInfo.innerHeight()-chatContButton.innerHeight()

    setHeightTeacherInfo = ->
      panelWorkshopInfo = $('#panel-workshop-info')
      chatContButton = $('#cont-chat-button')
      teacherInfoSectionOnModal.height window.innerHeight-panelWorkshopInfo.innerHeight()-chatContButton.innerHeight()-40

    fixPanel()
    setHeightTeacherInfo()

  Animations.onResize()

  

  $(window).on 'resize', ->
    Animations.onResize()
