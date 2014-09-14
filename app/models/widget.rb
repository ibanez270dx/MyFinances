class Widget < ActiveRecord::Base

  belongs_to :user

  serialize :data, JSON

end
