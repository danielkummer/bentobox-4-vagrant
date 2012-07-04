require 'carrierwave/test/matchers'
include ActionDispatch::TestProcess

describe VagrantboxUploader do
  include CarrierWave::Test::Matchers

  before do
    @vagrantbox = FactoryGirl.create(:vagrantbox)
    VagrantboxUploader.enable_processing = true
    @uploader = VagrantboxUploader.new(@vagrantbox, :box)
    @uploader.store!(File.open(File.join(Rails.root, 'spec', 'support', 'files', 'example.box')))
  end


  after do
    VagrantboxUploader.enable_processing = false
    @uploader.remove!
  end

  it "should make the box globally accessible" do
    @uploader.should have_permissions(0777)
  end
end