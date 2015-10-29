execute 'apt-get update' do
  command 'apt-get update'
end

include_recipe 'jenkins::master'