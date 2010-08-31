$(function() {
  
  var tabContainers = $('div#forms > div.innerContent');
  tabContainers.hide().filter(':first').show();
  $('ul.switcherTabs a').click(function () {
    tabContainers.hide();
    tabContainers.filter(this.hash).show();
    $('ul.switcherTabs li').removeClass('selected');
    $(this).parent().addClass('selected');
    return false;
  }).filter(':first').click();    
  
});
