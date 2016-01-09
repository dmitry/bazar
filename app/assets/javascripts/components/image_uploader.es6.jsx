class ImageUploader extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      images: this.props.images,
      dropOver: false
    };
  }

  renderItem(image) {
    let url = null;
    if (image.image) {
      url = image.image.toDataURL();
    } else {
      url = image.small_url;
    }

    let actions = null;
    if (image.image) {
      let style = {
        width: `${100 - image.percentage}%`
      };
      actions = [
        <div
          className="image-uploader__list__item__bar"
          style={style}>

        </div>,
        <div
          className="image-uploader__list__item__progress">
          {image.percentage}%
        </div>
      ];
    } else {
      actions = (
        <a
          href="#"
          onClick={this.onDelete.bind(this, image.id)}
          title={I18n.t('components.image_uploader.delete')}
          className="image-uploader__list__item__delete">

        </a>
      );
    }

    return (
      <div className="image-uploader__list__item" key={image.id}>
        <img src={url} className="image-uploader__list__item__image" />
        {actions}
      </div>
    );
  }

  renderList() {
    const list = _.map(this.state.images, (image) => {
      return this.renderItem(image)
    });

    return (
      <div className="image-uploader__list">
        {list}
      </div>
    );
  }

  renderUpload() {
    let dropClassName = 'image-uploader__upload__drop';
    if (this.state.dropOver) {
      dropClassName += ' image-uploader__upload__drop--visible';
    }


    return (
      <div className="image-uploader__upload">
        <div className="image-uploader__upload__button">
          <input
            type="file"
            className="image-uploader__upload__button__file"
            multiple
            ref="fileInput" />
          Choose photos
        </div>
        <div className="image-uploader__upload__message">
          or drag them with mouse here
        </div>
        <div className={dropClassName}>
          Drop photos here
        </div>
      </div>
    );
  }

  render() {
    return (
      <div className="image-uploader">
        {this.renderList()}
        {this.renderUpload()}
      </div>
    );
  }

  componentDidMount() {
    const uploadFiles = (files) => {
      FileAPI.filterFiles(
        files,
        (file, info) => {
          if (/^image/.test(file.type)) {
            return info.width >= 120 && info.height >= 90;
          }
          return false;
        },
        (files, rejected) => {
          if (files.length) {
            FileAPI.each(files, (file) => {
              FileAPI.Image(file).rotate('auto').preview(120, 90).get((err, img) => {
                var id = FileAPI.uid(file);

                this.state.images.push({
                  id: id,
                  image: img,
                  percentage: 0
                });

                this.setState(this.state.images);
              });
            });

            FileAPI.upload({
              url: this.getUrl(),
              files: {'file': files},
              fileprogress: (evt, file) => {
                var id = FileAPI.uid(file);
                var percentage = evt.loaded / evt.total * 100;

                // TODO use http://facebook.github.io/immutable-js/
                var item = _.find(this.state.images, (image) => { return id === image.id });
                item.percentage = percentage;

                this.setState(this.state.images);
              },
              filecomplete: (err, xhr, file) => {
                var id = FileAPI.uid(file);
                _.remove(this.state.images, (image) => {
                  return image.id === id;
                });
                this.state.images.push(JSON.parse(xhr.response)['photo']);

                this.setState(this.state.images);
              }
            });
          }
        }
      );
    };

    if (FileAPI.support.dnd) {
      $(document).dnd((over) => {
        this.setState({dropOver: over});
      }, (files) => {
        this.setState({dropOver: false});
        uploadFiles(files);
      });
    }

    FileAPI.event.on(this.refs.fileInput, 'change', function (evt) {
      var files = FileAPI.getFiles(evt);
      uploadFiles(files);
    });
  }

  onDelete(id, e) {
    e.preventDefault();

    $.ajax({
      url: `${this.props.url}/${id}`,
      method: 'DELETE',
      success: () => {
        _.remove(this.state.images, (image) => {
          return image.id === id;
        });
        this.setState(this.state.images);
      }
    });
  }

  getUrl() {
    const csrfName = $("meta[name='csrf-param']").attr("content");
    const csrfValue = encodeURIComponent($("meta[name='csrf-token']").attr("content"));
    return `${this.props.url}?${csrfName}=${csrfValue}`;
  }
}

ImageUploader.propTypes = {
  url: React.PropTypes.string
};
