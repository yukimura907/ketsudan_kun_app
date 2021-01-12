$(function () {
  $('.ui.icon.button.two').on('click', () => {
      $('.field.three').show();
      $('.ui.icon.button.two').hide();
  });
  $('.ui.icon.button.three.plus').on('click', () => {
      $('.field.four').show();
      $('.ui.icon.button.three').hide();
  });
  $('.ui.icon.button.four.plus').on('click', () => {
      $('.field.five').show();
      $('.ui.icon.button.four').hide();
  });

});

$(function () {
  $('.ui.icon.button.three.minus').on('click', () => {
      $('.field.three').hide();
      $('.ui.icon.button.two').show();
  });
  $('.ui.icon.button.four.minus').on('click', () => {
      $('.field.four').hide();
      $('.ui.icon.button.three').show();
  });
  $('.ui.icon.button.five').on('click', () => {
      $('.field.five').hide();
      $('.ui.icon.button.four').show();
});


});