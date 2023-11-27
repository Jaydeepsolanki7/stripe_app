class CheckoutController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    begin
      session = Stripe::Checkout::Session.create(
        customer: current_user.stripe_customer_id,
        payment_method_types: ['card'],
        line_items: [{
          quantity: 1,
        }],
        mode: 'payment',
        success_url: "#{root_url}",
        cancel_url: root_url,
      )

      redirect_to session.url, allow_other_host: true
  
    rescue Exception => e
      e.class 
    end
  end
end