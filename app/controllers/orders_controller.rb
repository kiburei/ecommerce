  
class OrdersController < ApplicationController
 before_action :current_cart, only: [:create, :reset_cart]

  require "uri"
  require "net/http"

  def create
    @order = Shop.last.orders.create(order_subtotal: @cart.sub_total_price, order_total: @cart.total_price, order_items_count: @cart.order_items.count, order_status: 'In Progress')
    @order.update(order_params)
    @cart.order_items.each do |order_item|
    @order.order_items.create!(quantity: order_item.attributes["quantity"], product_id: order_item.attributes["product_id"], size: order_item["size"], total_cost: order_item.attributes["total_cost"])
  end
    reset_cart
    redirect_to payment_path
  end
  def reset_cart
    puts @cart.order_items
    @cart.order_items.delete_all
    ShoppingCart.update_cart(@cart, current_shop)
  end

  #dispatch orders 
  def show 
    @order = Order.find(params[:id])
    
    if @order.order_payment_method == "Cash on Delivery"

        url = URI("http://sna.co.ke/sna_api/index.php")

        http = Net::HTTP.new(url.host, url.port);
        request = Net::HTTP::Post.new(url)
        form_data = [['function', 'sendMessage'],['phoneNumber', @order.client_phone_number],['message', "Hi #{@order.client_name}. Your Order Number #{@order.id} has been dispatched to #{@order.delivery}."],['senderId', 'COVERAPP'],['username', 'MALISAFI']]
        request.set_form form_data, 'multipart/form-data'
        response = http.request(request)
        puts response.read_body

    elsif @order.order_payment_method == "Mpesa"
      redirect_to root_url
    elsif @order.order_payment_method == "Card"
      redirect_to root_url
    elsif @order.order_payment_method == "Airtel Money"
       redirect_to root_url

    end

  end

  def payment
    @pay = Order.last
    if @pay.order_payment_method == "Mpesa"

        url = URI("https://payme.revenuesure.co.ke/index.php")

        https = Net::HTTP.new(url.host, url.port);
        https.use_ssl = true
        request = Net::HTTP::Post.new(url)
        form_data = [['TransactionType', 'CustomerPayBillOnline'],['PayBillNumber', '367776'],['Amount', @pay.order_total.to_i.to_s],['PhoneNumber', @pay.client_phone_number],['AccountReference', 'PKX2019062'],['TransactionDesc', 'PKX201906264'],['FullNames', '- - -']]
        request.set_form form_data, 'multipart/form-data'
        response = https.request(request)
        puts response.read_body
          
    elsif @pay.order_payment_method == "Card"
        redirect_to root_url

    elsif @pay.order_payment_method == "Airtel Money"  
         redirect_to root_url  

    elsif @pay.order_payment_method == "Cash on Delivery"  
      redirect_to cod_path
 
       url = URI("http://sna.co.ke/sna_api/index.php")

       http = Net::HTTP.new(url.host, url.port);
       request = Net::HTTP::Post.new(url)
       form_data = [['function', 'sendMessage'],['phoneNumber', @pay.client_phone_number],['message', "Hi #{@pay.client_name}. Your Order Number #{@pay.id} is being processed."],['senderId', 'COVERAPP'],['username', 'MALISAFI']]
       request.set_form form_data, 'multipart/form-data'
       response = http.request(request)
       puts response.read_body

       @pay.update(:order_status => "Completed")

       @pay.update(:payment_status => "Paid")

       
    end

  end

 
  def destroy
    @order = Order.find(params[:id])

    @order.destroy
      respond_to do |format|
        format.html { redirect_to edit_shop_registration_path, notice: 'Order was successfully cleared!.' }
        format.json { head :no_content }
      end
  end



  private


  def order_params
    params.permit(:client_name, :client_phone_number, :delivery, :order_payment_method)
  end



end
