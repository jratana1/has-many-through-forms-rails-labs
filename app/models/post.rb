class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  accepts_nested_attributes_for :categories

  def unique_comment_users
    users = self.comments.map do |comment|
              comment.user
            end

    users.uniq
  end

  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      

      if category_attribute[:name] != ""
      category = Category.find_or_create_by(category_attribute)
      self.categories << category
      end
    end
  end
end
