class Batch < ActiveRecord::Base
  has_many :stored_files
  belongs_to :user
  attr_accessible :user_id

  def self.new_temp_batch_id
    # just some small-ish string with 'good enough' randomness
    SecureRandom.hex(2)
  end

end
