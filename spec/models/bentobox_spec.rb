require 'spec_helper'

describe Bentobox do

  it { should have_fields(:name, :description) }
  it { should have_field(:public).of_type(Boolean) }
  it { should validate_presence_of :name }
  it { should belong_to :user }
  it { should belong_to :vagrantbox }
  it { should have_and_belong_to_many(:ingredients).as_inverse_of(:bentoboxes) }

  #howtodoit
  it { should custom_validate(:vagrantbox).with_validator(HasOneValidator) }


end

