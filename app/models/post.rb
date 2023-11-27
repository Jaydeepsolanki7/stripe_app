# app/models/post.rb
class Post < ApplicationRecord
  after_create :create_stripe_product

  private

  def create_stripe_product
    # Create a product in Stripe
    product = Stripe::Product.create(
      name: title, # or any other attribute of your post
      description: description, # or any other attribute of your post
      active: true
      # Add any additional parameters you need
    )

    # Store the Stripe product ID in your database
    update(stripe_product_id: product.id)
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: #{e.message}"
    errors.add(:base, "Unable to create Stripe product. Please try again.")
    throw :abort
  end
end
