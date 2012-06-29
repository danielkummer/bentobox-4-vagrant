require 'spec_helper'

describe Portmapping do
  it { should have_field(:port).of_type(Integer) }
  it { should validate_numericality_of :port }
  it { should validate_inclusion_of(:port).to_allow(1025..65535) }
  it { should be_embedded_in(:ingredient).as_inverse_of(:portmappings) }
end

