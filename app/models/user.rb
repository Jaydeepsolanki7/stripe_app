class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  after_create :create_stripe_customer

  private

  def create_stripe_customer
    customer = Stripe::Customer.create(
      email: email,
      name: name
    )
    update(stripe_customer_id: customer.id)
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: #{e.message}"
    errors.add(:base, "Unable to create Stripe customer. Please try again.")
    throw :abort
  end
end
