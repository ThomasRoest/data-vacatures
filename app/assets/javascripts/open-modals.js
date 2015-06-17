$(function(){
  $('#markdown-options-btn').on('click', function(e){
    e.preventDefault();
    var markdown_modal_content = "<div id='markdown-options'><p class='markdownoptions-title'>Gebruik Markdown voor uw bericht!</strong><p>";
    markdown_modal_content += "<p class='markdownoptions-title'>titels</p><h1>## Groot</h1><h3>### Middel</h3><h4>#### Klein</h4>";
    markdown_modal_content += "<p class='markdownoptions-title'>Lijsten: </p><ul><li> - item 1 </li><li> - item 2 </li><li> - item 3 </li></ul><br>";
    markdown_modal_content += "<ol><li>1. Genummerd </li><li>2. item 1 </li></ol><p class='markdownoptions-title'>Links toevoegen:</p><p>http://mijnlink.nl</p>";
    markdown_modal_content += "<p>of:</p><p>[Link tekst](http://mijnlink.nl)</p><p class='markdownoptions-title'>Tekst opmaak</p><p><b>**Bold**</b></p><p><em>*Italic*</em></p></div>";
  
    modal.open({content: markdown_modal_content});

    $('#close-default-modal').on('click', function(e){
      modal.close();
    });
  });

  $('#open-stripe-modal').on('click', function(e){
    e.preventDefault();
    var stripe_modal_content = "Met Stripe worden creditcardgegevens niet opgeslagen, maar direct via een veilige verbinding verstuurd en verwerkt.";
    modal.open({content: stripe_modal_content});

    $('#close-default-modal').on('click', function(){
      modal.close();
    });
  });

});