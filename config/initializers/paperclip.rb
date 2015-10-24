Paperclip::Attachment.default_options.merge!(
  path: ':rails_root/public/:url',
  url: '/system/:class/:attachment/:style/:id_partition.:extension',
  default_url: '/images/missing/:class/:attachment/:style.png',
  convert_options: {all: ['-auto-orient -strip']},
  preserve_files: true
)
