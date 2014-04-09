class Players::SessionsController < Devise::SessionsController
  def new
    @page_id = :sign_in
    super
  end
end