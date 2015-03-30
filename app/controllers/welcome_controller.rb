require 'net-http-spy'

class WelcomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :get_session
  
  def get_session
    $VERBOSE = true
    Net::HTTP.http_logger_options = {:body => true}
    Net::HTTP.http_logger_options = {:trace => true}
    Net::HTTP.http_logger = Logger.new('net.log')
    ShopifyAPI::Session.setup({:api_key => ENV['API_KEY'], :secret => ENV['SHARED_SECRET']})
    @shopify_session = ShopifyAPI::Session.new("touch-demo.myshopify.com")
  end  
  
  
  def index
        #params = {"code"=>"b9bf3c359a92baa789cce61333c67ff3", "hmac"=>"6ef21153359dbffb0b749c751037a3aa6c5119b9f56974eb11885d5c29c04e65", "shop"=>"touch-demo.myshopify.com", "signature"=>"711e88f9375a2b60ca8e4b42fae61e0b", "timestamp"=>"1427694639", :action => "", "controller" => ""}  
    scope = ["write_orders"]
    @permission_url = @shopify_session.create_permission_url(scope, "http://white-harrenhal-63-197069.apse2.nitrousbox.com/red")        
    
  end  
  
  def red
    #ShopifyAPI::Session.setup({:api_key => ENV['API_KEY'], :secret => ENV['SHARED_SECRET']})
    #@shopify_session = ShopifyAPI::Session.new("touch-demo.myshopify.com")
    token = @shopify_session.request_token(params)  
    ShopifyAPI::Base.activate_session(@shopify_session)
    @new_product = ShopifyAPI::Product.new
    @new_product.title = "Burton Custom Freestlye 151"
    @new_product.product_type = "Snowboard"
    @new_product.vendor = "Burton"
    @new_product.save
  end  
end
