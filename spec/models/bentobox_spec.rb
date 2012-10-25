require 'spec_helper'

describe Bentobox do
  it "should have a valid factory" do
    Fabricate.build(:bentobox).should be_valid
  end

  it { should have_fields(:name, :description, :public) }
  it { should have_field(:public).of_type(Boolean) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :vagrantbox }

  it { should belong_to :user }
  it { should belong_to :vagrantbox }
  it { should have_many :client_nodes }
  it { should have_and_belong_to_many(:ingredients).as_inverse_of(:bentoboxes) }

  it { should be_timestamped_document }

end

