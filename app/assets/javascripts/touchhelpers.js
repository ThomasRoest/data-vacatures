$(function(){

  $('.touch-item-jobs').on('click', function(){
    var jobsBody = $(this).children('div');
    var jobsTitle = jobsBody.children('h2').children('a');
    var jobsContent = jobsBody.children('span');

    jobsTitle.css('color', '#fff');
    jobsContent.css('color', '#fff');
    $(this).css('background-color', '#64B5F6');

    window.location = $(this).find(".showpost-link").attr("href");

  });
// #6495ED
  // $('.touch-item-feed').css('background-color', '#fff');
  // prevent firefox bug when returning to the feed
  $(".touch-item-feed").on('click', function(){ 
    var feedTitle = $(this).children('.media-body').children('h2').children('a');
    var feedContent = $(this).children('.media-body').children('.feed-item-content').children();
    
    $(this).css("background-color","#64B5F6");
    feedTitle.css('color', '#fff');
    feedContent.css('color', '#fff');
    //select hidden showpost link in the timestamp span
    window.location = $(this).find(".showpost-link").attr("href");
  });


  $("#touch-item-newpost").on('click', function(){
    $(this).css({'background-color': '#6495ED',
                  'color': '#FFF'});
    //select hidden showpost link in the timestamp span
    window.location = $(this).find(".newpost-link").attr("href");
  });

});





