$(function() {
  $(".up_link").live('click', function() {
    var data = $(this).attr('id');
    var url = "/user_projects/" + data;
    $.ajax({
      url: url,
      data: data,
      type: 'DELETE'
    })
    return false;
  });
  
  $("#new_user_project").submit(function() {
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