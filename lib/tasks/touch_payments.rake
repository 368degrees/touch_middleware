namespace :touch_payments do
  desc "TODO"
  task create_order: :environment do
    #ShopifyAPI::Session.setup({:api_key => ENV['API_KEY'], :secret => ENV['SHARED_SECRET']})
    params = {"code"=>"b9bf3c359a92baa789cce61333c67ff3", "hmac"=>"6ef21153359dbffb0b749c751037a3aa6c5119b9f56974eb11885d5c29c04e65", "shop"=>"touch-demo.myshopify.com", "signature"=>"711e88f9375a2b60ca8e4b42fae61e0b", "timestamp"=>"1427694639", :action => "", "controller" => ""}  
    
   
    #scope = ["write_orders"]
    #permission_url = session.create_permission_url(scope, "https://my_redirect_uri.com")
    session = ShopifyAPI::Session.new("touch-demo.myshopify.com")
    token = session.request_token(params)  
    ShopifyAPI::Base.activate_session(session)
    shop = ShopifyAPI::Shop.current
    puts shop.to_yaml
  end

end
