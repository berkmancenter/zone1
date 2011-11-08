class RightAssignment < ActiveRecord::Base
  belongs_to :right
  belongs_to :subject, :polymorphic => true
  attr_accessible :right_id
end
