Fabricator(:vagrantbox) do
  name {Faker::Product.brand }
  box {
    ActionDispatch::Http::UploadedFile.new(
      :tempfile => File.new(Rails.root.join("spec/support/files/example.box")),
      :filename => File.basename(File.new(Rails.root.join("spec/support/files/example.box")))
    )
  }
  #  after_create { |brand| brand.file = File.open(File.join(Rails.root,'spec','support','brands','logos','logo_image.jpg')) } # has to exist
end
