class AddStripeProductIdToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :stripe_product_id, :string
  end
end
