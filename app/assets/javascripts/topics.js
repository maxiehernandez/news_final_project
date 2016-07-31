$(function() {
  $("#topic").sortable({
    axis: "y",
    containment: "#topic",
    update: function( event, ui ) {
      // console.warn( $(this).sortable('serialize') );
      $.post( $(this).data('topic-url'), $(this).sortable('serialize'))
    }
  });
});
