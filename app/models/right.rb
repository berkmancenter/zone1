class Right < ActiveRecord::Base
  validates_presence_of :action
  validates_uniqueness_of :description

  has_many :right_assignments

  attr_accessible :action, :description

  # TODO: Potentially implement this as a has_many :through, but note is polymorphic
  def roles
    role_ids = self.right_assignments.inject([]) { |arr, ra| arr << ra.subject_id if ra.subject_type == "Role"; arr }.uniq
    Role.find_all_by_id(role_ids)
  end
end
