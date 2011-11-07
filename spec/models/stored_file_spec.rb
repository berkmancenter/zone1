require 'spec_helper'

describe StoredFile do
  it { should belong_to :license }
  it { should belong_to :user }
  it { should belong_to :content_type }
  it { should belong_to :access_level }
  it { should belong_to :batch }
  it { should have_many :comments }
  it { should have_many :flaggings }
  it { should have_many :flags }
  it { should have_and_belong_to_many :groups }
  it { should have_one :disposition }

  it { should accept_nested_attributes_for :flaggings }
  it { should accept_nested_attributes_for :disposition }

  it { should allow_mass_assignment_of :file }
  it { should allow_mass_assignment_of :license_id }
  it { should allow_mass_assignment_of :collection_name }
  it { should allow_mass_assignment_of :author }
  it { should allow_mass_assignment_of :title }
  it { should allow_mass_assignment_of :copyright }
  it { should allow_mass_assignment_of :description }
  it { should allow_mass_assignment_of :access_level_id }
  it { should allow_mass_assignment_of :user_id }
  it { should allow_mass_assignment_of :content_type_id }
  it { should allow_mass_assignment_of :original_filename }
  it { should allow_mass_assignment_of :flag_ids }
  it { should allow_mass_assignment_of :batch_id }
  it { should allow_mass_assignment_of :allow_notes }
  it { should allow_mass_assignment_of :delete_flag }
  it { should allow_mass_assignment_of :office }
  it { should allow_mass_assignment_of :tag_list }
  it { should allow_mass_assignment_of :publication_type_list }
  it { should allow_mass_assignment_of :collection_list }
  it { should allow_mass_assignment_of :disposition }
  it { should allow_mass_assignment_of :group_ids }
  it { should allow_mass_assignment_of :flaggings_attributes }
  it { should allow_mass_assignment_of :disposition_attributes }


end
