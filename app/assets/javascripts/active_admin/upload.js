$(function() {
  var upload = $('.upload');
  if (upload.length) {
    var uploadFile = upload.find('.upload__button__file');
    var uploadFileEl = uploadFile[0];

    var csrfName = $("meta[name='csrf-param']").attr("content");
    var csrfValue = encodeURIComponent($("meta[name='csrf-token']").attr("content"));
    var url = upload.data('url');
    url += '?' + csrfName + '=' + csrfValue;


    var uploadFiles = function(files) {
      FileAPI.filterFiles(files, function (file, info) {
        if (/^image/.test(file.type)) {
          return info.width >= 320 && info.height >= 240;
        }
        return false;
      }, function (files, rejected) {
        if (files.length) {
          FileAPI.each(files, function (file) {
            FileAPI.Image(file).preview(128).get(function (err, img) {
              var id = FileAPI.uid(file);
              var item = $('<div class="upload__list__item upload__list__item--incompleted" id="' + id + '" />');
              item.append(img);
              item.append('<div class="upload__list__item__bar"><div class="upload__list__item__bar__completed"></div></div>');
              upload.find('.upload__list').append(item);
            });
          });

          FileAPI.upload({
            url: url,
            files: {'photo[file]': files},
            fileprogress: function (evt, file) {
              var percentage = evt.loaded / evt.total * 100;

              var id = FileAPI.uid(file);
              var item = $(document.getElementById(id));
              if (percentage < 100) {
                item.
                  find('.upload__list__item__bar__completed').
                  css('width', percentage + '%');
              } else {
                item.find('.upload__list__item__bar').remove();
                item.removeClass('upload__list__item--incompleted');
              }
            },
            complete: function (err, xhr) {

            }
          });
        }
      });
    };

    if(FileAPI.support.dnd) {
      $(document).dnd(function(over) {
        $('.upload__drop').toggle(over);
      }, function(files) {
        uploadFiles(files);
      });
    }

    FileAPI.event.on(uploadFileEl, 'change', function(evt) {
      var files = FileAPI.getFiles(evt);
      uploadFiles(files);
    });
  }
});