function ready() {
  $('#new_topic').on('ajax:success', newTopic);

  function newTopic(event, data) {
  $('.topic').append(data);
}
}

$(document).on("ready", ready);
