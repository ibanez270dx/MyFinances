class Widget < ActiveRecord::Base

  belongs_to :user

  validates :user_id, presence: true

  serialize :data, JSON

  def url_name
    type.split('::').last.paramify
  end

end
