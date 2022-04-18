class AddEntry < ActiveRecord::Migration[5.2]
  def change
    AdminUser.create!(email: 'admin@awsetawah.com', password: 'AwsEtawah@2022', password_confirmation: 'AwsEtawah@2022')
  end
end
