class Example < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :tags, dependent: :destroy
  accepts_nested_attributes_for :comments, allow_destroy: true
  accepts_nested_attributes_for :tags, allow_destroy: true

  validates :text, presence: true

  def editable?(current_user)
    return false if current_user.nil?
    self.user == current_user || current_user.level >= 5
  end

  def verified_or_not
    self.verified ? 'Yes' : 'No'
  end

  def user_name
    return 'Anonymous' if self.user.nil?
    self.user.name
  end
end
