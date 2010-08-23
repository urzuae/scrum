$(function() {
  
  $(".new_task").css("display","none");
  
  $(".task").click(function() {
    var id="#"+ $(this).attr("name");
    $(id).toggle("slow");
  });
  
  $(".new_task").live('submit', function() {
    var data = $(this).serialize();
    var url = $(this).attr('action');
    $.ajax({
      data: data,
      url: url,
      type: 'post'
    });
    return false;
  });
  
});
