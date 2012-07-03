require 'spec_helper'

describe ShareFolder do
  it { should have_fields(:logical_name, :host_path, :guest_path, :additional_options) }
  it { should validate_presence_of :logical_name, :host_path, :guest_path }
  it { should validate_uniqueness_of :logical_name }

end
