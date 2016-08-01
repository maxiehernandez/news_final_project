
function twitterDrag(event){
   $(".twitter-tweet").draggable();
}

$(document).on('ready', function(event){
  event.preventDefault();
});
$('twitterwidget').on('change', function(e){
  e.preventDefault();
})
setTimeout(function() {
  twitterDrag();
}, 1000);

// this is to make twitter draggable from stack overflow
// function handler(event,ui){
//                 $.ajax({
//                     type: "POST",
//                     url: '/dashboard' + $(ui.draggable).attr("class"),
//                     success: function (data) {
//                         $('.draggable').draggable('destroy');
//                         // $('.EmbeddedTweet-tweet div').replaceWith(data);
//                         $('.draggable').draggable({ revert: true });
//
//                     }
//              $('.EmbeddedTweet-tweet div').droppable({drop: handler});
// }
//
//
// $(function () {
//         $('.draggable').draggable({ revert: true });
//         $('.EmbeddedTweet-tweet div').droppable({drop: handler});
//
//     });





//
// //  sample of what code should look like from henry
//  $.ajax({
//    url: "url making the post",
//    method: "POST",
//    data: { data : "Here is the data you passing" }
//  }).done(function( data_got_from_ajax ) {
//    console.log( data_got_from_ajax );
//  });
//
//
