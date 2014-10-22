# http://blog.sorryapp.com/2013/03/22/request-and-controller-specs-with-devise.html

# This support package contains modules for authenticaiting
# devise users for request specs.

# This module authenticates users for request specs.#
module ValidAdminRequestHelper
  # Define a method which signs in as a valid user.
  def sign_in_as_a_valid_admin
    # Ask factory girl to generate a valid user for us.
    @admin ||= FactoryGirl.create :admin

    # We action the login request using the parameters before we begin.
    # The login requests will match these to the user we just created in the factory, and authenticate us.
    post_via_redirect admin_session_path,
                      'admin[email]' => @admin.email,
                      'admin[password]' => @admin.password
  end
end

# Configure these to modules as helpers in the appropriate tests.
RSpec.configure do |config|
  # Include the help for the request specs.
  config.include ValidAdminRequestHelper, type: :request
end
