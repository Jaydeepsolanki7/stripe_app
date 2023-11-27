class SubscriptionsController < ApplicationController
  def create
    debugger
    post = Post.find(params[:post_id])

    # Create a customer on Stripe
    customer = Stripe::Customer.create(
      email: current_user.email,
      source: params[:stripeToken] # token obtained with Stripe.js
    )

    # Create a subscription
    subscription = Stripe::Subscription.create(
      customer: customer.id,
      items: [{ price: 'your_price_id' }] # replace with your actual price ID
    )

    # Save subscription information in your database
    Subscription.create(user: current_user, post: post, stripe_subscription_id: subscription.id)

    redirect_to post_path(post), notice: 'Successfully subscribed!'
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to post_path(post)
  end
end
