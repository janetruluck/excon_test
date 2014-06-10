require 'carrierwave/orm/activerecord'

class Item < ActiveRecord::Base
  # Validations
  validates :name, presence: true

  mount_uploader :poster, PosterUploader
end
