namespace :admin do
  desc 'Add the user'
  task create_user: :environment do
    email = ENV['EMAIL'].presence
    fail "No email address. Specify `EMAIL'." unless email
    password = ENV['PASSWORD'].presence
    fail "No password. Specify `PASSWORD'." unless password
    adm = Admin.create(
      email: email,
      password: password
    )
    fail "Failed to create an admin account. Errors: #{adm.errors.full_messages.join(', ')}" if adm.errors.present?
  end
end
