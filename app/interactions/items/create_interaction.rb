module Items
  class CreateInteraction < ActiveInteraction::Base
    PASSWORD_LENGTH = 16

    object :item, class: Item

    array :translations_attributes do
      hash do
        string :name
        string :locale
        string :description
      end
    end

    array :photos_ids, default: nil

    string :price
    string :category_id
    string :condition_id

    string :name
    string :email
    string :phone

    def to_model
      item
    end

    def photos
      if photos_ids
        Photo.where(id: photos_ids)
      else
        item.photos
      end
    end

    def execute
      transaction do
        user = find_user_by_phone_or_email
        user.assign_attributes(user_params)

        item.assign_attributes(item_params)
        item.user = user

        unless item.save
          errors.merge!(user.errors)
          errors.merge!(item.errors)
        end
      end

      item
    end

    private

    def transaction(&block)
      ActiveRecord::Base.transaction(&block)
    end

    def item_params
      inputs.slice(
        :translations_attributes,
        :price,
        :category_id,
        :condition_id
      )
    end

    def user_params
      inputs.slice(
        :email,
        :phone,
        :name
      )
    end

    def find_user_by_phone_or_email
      User.by_phone_or_email(phone, email).first ||
        User.new(password: generate_password)
    end

    def generate_password
      SecureRandom.hex(PASSWORD_LENGTH / 2)
    end
  end
end
