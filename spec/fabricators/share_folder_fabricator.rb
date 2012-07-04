Fabricator(:share_folder) do
  logical_name "testshare"
  host_path "host/path"
  guest_path "guest/path"
  additional_options "additional"
end
