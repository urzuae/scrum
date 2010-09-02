$(function() {
  
  $(".forms").hide();
  
  $(".task").click(function() {
    var id="#form_" + $(this).attr("name");
    $(id).show();
  });
  
  $(".task_forms").hide();
  
  $(".comment").click(function() {
    var id="#task_"+ $(this).attr("name");
    $(id).css('display', 'block');
    Elastic.refresh();
  });
  
  $(".datepicker").datepicker({
    maxDate: '0',
    dateFormat: 'yy-mm-dd',
    onSelect: function(dateText) {
      location.href = "?day=" + dateText;
    }
  });
  
  
});
