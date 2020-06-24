module Shopify
  class Shop < ActiveRecord::Base
    include ShopifyApp::ShopSessionStorage

    SHOP_QUERY = ShopifyAPI::GraphQL.client.parse <<-'GRAPHQL'
      {
        shop {
          name
          url
        }
      }
    GRAPHQL

    CREATE_CUSTOMER_QUERY = ShopifyAPI::GraphQL.client.parse <<-'GRAPHQL'
      mutation($input: CustomerInput!) {
        customerCreate(input: $input) {
          customer {
            id
            displayName
          }
          userErrors {
            field
            message
          }
        }
      }
    GRAPHQL
  end
end
