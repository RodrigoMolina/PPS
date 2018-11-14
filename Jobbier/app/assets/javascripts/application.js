// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require_tree ./animations
//= require turbolinks
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require version
//= require bootstrap
//= require select2/select2.min
//= require select2/i18n/es
//= require snackbars/snackbar
//= require dist/js/app.js
//= require ace/ace.js
//= require iCheck/icheck.js
//= require_tree ../../../vendor/assets/plugins/moo_editable/js/
//= require moment
//= require moment/moment.es.js
//= require bootstrap-datetimepicker
//= require gmaps/gmaps.js
//= require_tree ./initializers
//= require social-share-button
//= require sweetalert2
//= require sweet-alert2-rails

//= require serviceworker-companion

Array.prototype.diff = function(a) {
    return this.filter(function(i) {return a.indexOf(i) < 0;});
};


