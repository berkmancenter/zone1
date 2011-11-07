class License < ActiveRecord::Base
  belongs_to :stored_file

  attr_accessible :name
end
