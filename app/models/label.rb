class Label < ActiveRecord::Base
  attr_accessible :color_hex, :detail, :title, :user_id, :x, :y
  belongs_to :user_id
end
