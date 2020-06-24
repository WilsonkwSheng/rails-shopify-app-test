# README

Assuming you have shopify store and app is ready. You will need API key and secret from Shopify.

* In order to use this on development. You may need to install ngrok.
* To install ngrok enter $ brew cask install ngrok.
* Afterwards, enter $ rails s and then $ ngrok http 3000.
* Always change your redirect uri for App URL and Whitelisted redirection URL(s) in https://partners.shopify.com with the values get from ngrok terminal. You may have to keep change the url as ngrok have expiry usage.
* Reference on how to setup shopify_app: http://www.codeshopify.com/blog_posts/setting-up-a-shopify-embedded-app-with-rails

* Before getting started from GraphQL
import schema from shopify app
$ rake shopify_api:graphql:dump
# Additional configuration would be needed refer to terminal.

* under config/initializer/shopify_app.rb
config.scope = "read_orders, write_orders ... etc"
# You will need certain access in order to query/mutate Shopify data.

* For GraphQL Query
From controller initialize a call to graphql query
@shop = client.query(Shopify::Shop::SHOP_QUERY)
```
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
    end
  end
end
```

* For GraphQL Mutation
From controller initialize a call to graphql query
variables = {
  "input": {
    "firstName": params[:first_name],
    "lastName": params[:last_name],
    "email": params[:email]
  }
}
response = client.query(Shopify::Shop::CREATE_CUSTOMER_QUERY, variables: variables)
```
module Shopify
  class Shop < ActiveRecord::Base
    include ShopifyApp::ShopSessionStorage
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
end
```
