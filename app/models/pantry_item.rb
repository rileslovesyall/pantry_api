class PantryItem < ActiveRecord::Base
  belongs_to :user
  has_many :pantry_item_categories
  has_many :categories, through: :pantry_item_categories

  validates_presence_of :name, :quantity, :user_id

  def set_expiration_email
    # TODO add code here
  end

  def self.public
    return self.where(show_public: true, consumed: false)
  end



end