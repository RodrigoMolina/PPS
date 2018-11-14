$( document ).on('turbolinks:load', function() {

  var button = $('#notification-button');
  var circle = $('#notification-button > .circle');
  var panel = $("#notification-panel");
  var list = $("#notification-panel > .list-notification");
  var item = $("#notification-panel > .list-notification > .item-notification");
  var counter = $("#counter-notification");

  //button.click(function(){
  //  circle.removeClass('motion-on');
  //  counter.text(0);
  //  counter.css('display', 'none');
  //  panel.toggle('fast');
  //})

 //var activeNotification = function () {
 //  circle.addClass('motion-on');
 //}

 //var setPanelHeight = function() {
 //  var addOverflowY = function () {
 //    return list.addClass('list-overflow')
 //  }
 //  var removeOverflowY = function () {
 //    return list.removeClass('list-overflow')
 //  }
 //  item.get().forEach(function(i, el, arr){
 //    arr.length > 3? addOverflowY() : removeOverflowY()
 //  });
 //}

  //activeNotification();
  //setPanelHeight();

});
