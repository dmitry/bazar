class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :small_url, :medium_url, :large_url

  def small_url
    object.file.url(:small)
  end

  def medium_url
    object.file.url(:medium)
  end

  def large_url
    object.file.url(:large)
  end
end
