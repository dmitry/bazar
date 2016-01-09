$(function() {
  $('[data-segment-toggler]').on('click', function(e) {
    e.preventDefault();
    $(this).parents('.segment').toggleClass('segment--hidden');
  });
});
