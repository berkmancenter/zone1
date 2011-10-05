class Batch < ActiveRecord::Base
  has_many :stored_files
  belongs_to :user
end
