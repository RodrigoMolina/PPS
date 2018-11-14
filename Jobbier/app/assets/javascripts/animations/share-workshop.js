$( document ).on('turbolinks:load', function() {

  var shareButton = $('#share-workshop')
  var closeShare = $('#close-share')
  var shareOptions = $('#share-options')

  shareButton.click(function(e){
    e.stopPropagation()
    this.addClass('expand-share-options')
    $('#share-workshop > .fa-share-alt').hide()
    shareOptions.fadeIn(1000)
  })

  closeShare.click(function(e){
    e.stopPropagation()
    shareButton.removeClass('expand-share-options')
    $('#share-workshop > .fa-share-alt').show()
    shareOptions.hide()
  })

  $('#copy-button').click(function(){
    var copyText = $("#workshopPathToCopy")
    copyText.select()
    document.execCommand("Copy")
  })

});
