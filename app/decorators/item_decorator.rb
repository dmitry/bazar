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
end
