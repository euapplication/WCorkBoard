class Label < ActiveRecord::Base
  attr_accessible :detail, :height, :title, :user_id, :width
  
  belongs_to :user_id
end
