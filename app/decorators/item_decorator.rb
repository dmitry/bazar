class ItemDecorator < Draper::Decorator
  delegate_all

  def price
    "#{object.price} &euro;".html_safe
  end

  def category
    object.category.name
  end

  def condition
    object.condition.name
  end

  def published_date_at
    created_at.strftime('%d.%m.%Y')
  end

  def description
    string = Kramdown::Document.new(object.description).to_html
    string = Sanitize.fragment(string, :elements => %w(b p br))
    string.html_safe
  end
end
