var initialize = function() {
  var root = $('.item');

  if (root.length) {
    var photos = root.find('.item__photos');
    if (photos.length) {
      photos.magnificPopup({
        type: 'image',
        delegate: '.item__photos__photo',
        gallery: {
          enabled: true
        },
        preload: [1, 2],
        zoom: {
          enabled: true
        },
        duration: 300,
        easing: 'ease-in-out'
      });
    }

    if ($('.item__photos__photo').length) {
      $('.item__photo').on('click', function (e) {
        e.preventDefault();
        $('.item__photos').magnificPopup('open');
      });
    } else {
      $('.item__photos__photo').magnificPopup({
        type: 'image',
        zoom: {
          enabled: true
        },
        duration: 300,
        easing: 'ease-in-out'
      });
    }
  }
};

$(initialize);
$(document).on('page:load', initialize);
