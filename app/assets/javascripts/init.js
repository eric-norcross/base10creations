$(document).ready(function(){
  $('#product-collection select').change(function() {
    console.log("test");

    var collection_id = $("option:selected", this).val();
    $.post("/components/retrieve_components/" + collection_id, function(data){
        $("#product-components").html(data);
        console.log(data);
    });
  });


  $("a.print").click(function(event) {
    window.print();
  });
  
  $(".gallery").each(function(index) {
    var gallery = new Gallery($(this));
    gallery.init();
  });

  $('.carousel').carousel({
    interval: 3000
  });

  $('#product_search').focus(function(){
    if ($(this).val() == "Keyword or item #"){
      $(this).val("");
    }
  });

  $('#product_search').blur(function(){
    if ($(this).val() == ""){
      $(this).val("Keyword or item #");
    }
  });
  
  $('#retailer_search').focus(function(){
    if ($(this).val() == "Find a dealer near you"){
      $(this).val("");
    }
  });

  $('#retailer_search').blur(function(){
    if ($(this).val() == ""){
      $(this).val("Find a dealer near you");
    }
  });

});