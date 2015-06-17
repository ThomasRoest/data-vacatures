$(document).ready(function(){
  $('#ul-nav-toggle').click(function(e) {
      e.preventDefault();
      $('#ul-nav-menu').toggleClass('open');
      $(this).toggleClass('menu-toggle-active');
      
    });

$('#show-embed-url').on("click", function(){
  $('.embed-input').removeClass("hide");
})

   
$("#ul-dropdown-toggle").click(function(){
  $("#ul-dropdown-menu").toggleClass("open-dropdown");
  console.log("open dropdown");
  event.preventDefault();
});


var $searchContainer = $('#search-form-container');

$('#show_search').on('click', function(e){
  e.preventDefault();
  $searchContainer.removeClass('hide');
  $('.btn-search').removeClass('btn-search-margin');
  $(this).hide();

});

});

