class ApplicationController < Sinatra::Base
  set :views, File.expand_path('../../views', __FILE__) #for css
  set :public_folder, File.expand_path('../../public', __FILE__) #for css

    get '/' do
      erb :homepage
    end


#params receipt with issuer name
    post '/get-issuer-name' do
      receipt = Receipt.new(params[:receipt])
        if receipt.save
          redirect "/add-product/#{receipt.id}"
        else
          "Sorry, an error has occured."
        end
    end

#shows issuer name with receipt_id assigned then redirects to add new product page here
    get '/add-product/:receipt_id' do
      # @issuer = Receipt.find(params[:receipt_id])
      @receipt = Receipt.find(params[:receipt_id])
      @products = @receipt.products.all #array of products
      erb :add_product_page
    end

#post for creating product
    post '/get-product/:receipt_id' do
      receipt = Receipt.find(params[:receipt_id]) #this will find the route of receipt
      product = receipt.products.new(params[:product]) #this will create association with receipt previously
        if product.save
          redirect "/add-product/#{params[:receipt_id]}"
        else
          "Sorry, an error has occured."
        end
    end

 # #redirect to show products on the way to checkout
 #    get '/get-checkout-products/:receipt_id' do
 #      @receipt = Receipt.find(params[:receipt_id])
 #      @products = @receipt.products.all #array of products
 #
 #      erb :get_checkout_products
 #    end

  #delete product
    get "/receipt/:receipt_id/product/:product_id/delete" do
      receipt = Receipt.find(params[:receipt_id])
      product = Product.find(params[:product_id])
        if product
          product.destroy
          redirect "/add-product/#{receipt.id}"
        else
          "Sorry, an error has occured."
        end
      end

  #edit product
    get "/receipt/:receipt_id/product/:product_id/edit" do
      @receipt = Receipt.find(params[:receipt_id])
      @product = Product.find(params[:product_id])
      @products = @receipt.products.all
      erb :edit_product_page
    end

    post '/receipt/:receipt_id/product/:product_id/edit' do
      receipt = Receipt.find(params[:receipt_id])
      product = Product.find(params[:product_id])
        if product
          product.update(params[:product])
          redirect "/add-product/#{receipt.id}"
        else
          "Sorry, an error has occured."
        end
    end


end
