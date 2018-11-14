window.SweetAlert ||= {}

$ ->

  SweetAlert.initConfig = ->

    window.sweetAlertConfirmConfig = {
      type: 'warning',
      confirmButtonColor: '#ad2fad',
      confirmButtonText: 'Ok'
    }
