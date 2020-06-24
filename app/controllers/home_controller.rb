# frozen_string_literal: true

class HomeController < AuthenticatedController
  def index
    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    @webhooks = ShopifyAPI::Webhook.find(:all)
    # @customers = ShopifyAPI::Customer.find(:all, params: { limit: 10 })
    # client = ShopifyAPI::GraphQL.client
    # @shop = client.query(Shopify::Shop::SHOP_QUERY)
  end
end
