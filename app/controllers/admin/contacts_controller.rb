class Admin::ContactsController < Admin::SessionController
  def index
    @contacts = Contact.all.order(created_at: :desc)
  end
end
