class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :orders, dependent: :destroy
         has_many :reviews, dependent: :destroy
         belongs_to :address, optional: true

        attribute :role, :string
         enum role: { user: "user", admin: "admin" }

        before_create :set_default_role


        def admin?
          role == "admin"
        end

        def user?
          role == "user"
        end

        def set_default_role
          self.role ||= "user"
        end
end
