require "active_merchant"

ActiveMerchant::Billing::Base.mode = :production # Використовуйте :production у бойовому середовищі

STRIPE_GATEWAY = ActiveMerchant::Billing::StripeGateway.new(
  login: Rails.application.credentials.dig(:stripe, :secret_key)
)
