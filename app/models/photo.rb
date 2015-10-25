class Photo < ActiveRecord::Base
  belongs_to :item

  has_attached_file(
    :file,
    styles: {
      small: ['120x90#', :jpg],
      medium: ['900x600#', :jpg],
      large: ['1800x1200>', :jpg]
    },
    convert_options: {
      small: '-quality 80',
      medium: '-quality 80',
      large: '-quality 75'
    }
  )

  validates_attachment_presence :file
  validates_attachment_content_type :file, content_type: %w(image/jpeg image/jpg image/png)

  scope :without_item, -> { where(item_id: nil) }
end
