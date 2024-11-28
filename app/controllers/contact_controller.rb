# app/controllers/contact_controller.rb
class ContactController < ApplicationController
  def new
    @contact = Contact.new
    if user_signed_in?
      @contact.name = current_user.name
      @contact.email = current_user.email
    end
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      flash[:notice] = "Ваше повідомлення надіслано. Дякуємо за звернення!"
      redirect_to contact_path
    else
      flash[:alert] = "Помилка при відправці повідомлення. Спробуйте ще раз."
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
