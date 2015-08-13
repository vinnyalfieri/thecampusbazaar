class OffersController < ApplicationController

  def new 
    @user = User.find(params[:user])  #seller of the item 
    @item = Item.find(params[:item])  #item the offer is about
  end 

  def create
    params["offer"]["payment_option_ids"] = ["2"] if params["offer"]["payment_option_ids"] == [""]
    offer = Offer.new(offer_params)
    if offer.save
      flash[:notice] = "Offer has been submitted!"
    else
      flash[:notice] = "There was an error with your form"
    end
    redirect_to root_path
  end 


  def show    
    @offer = Offer.find(params[:id])
    @item = @offer.item
  end

  def sent
    @pending_offers = current_user.pending_offers_sent
    # get all pending offers of the current user
    @rejected_offers = current_user.rejected_offers_sent
    # get all rejected offers of the current user
    @accepted_offers = current_user.accepted_offers_sent
    # get all accepted offers of the current user
  end

  def received
    @available_items = current_user.items.select{|item| item.available?}
    @sold_items = current_user.items.reject{|item| item.available?}
    @count = current_user.offers_received.count
  end

  def accepted
    offer = Offer.find(params[:id])

    case params[:payment_method]
    when "Venmo"
      transaction_status = offer.charge_venmo
    when "Cash"
      transaction_status = "cash"
    else
      transaction_status = nil
    end

    if transaction_status == "settled" || transaction_status == "cash"
      offer.settle
    end
    
    flash[:notice] = offer_flash_message(transaction_status, offer)
    redirect_to offers_received_path
  end 

  def rejected
    offer = Offer.find(params[:id])
    offer.status = 'rejected'
    offer.save
    redirect_to offers_received_path
  end 

  def confirm
    @buyer = Offer.find(params[:id]).buyer
    @offer = Offer.find(params[:id])
  end 

  def destroy
    Offer.destroy(params[:id])
    redirect_to offers_sent_path
  end

  private

    def offer_params
      params.require(:offer).permit(:buyer_id, :item_id, :offer_price, :comment, :payment_option_ids => [])
    end

    def offer_flash_message(flag = nil,offer)
      messages = {
        settled: "You have successfully charged #{offer.buyer.name} for #{offer.offer_price}!", 
        pending: "A charge request has been sent to #{offer.buyer.name}. They will need to accept your Venmo charge manually.",
        failed: "Charging #{offer.buyer.name} was unsuccessful. Contact them for more info.",
        cash: "You have agreed to transact with cash. Please contact the buyer to establish a meeting time, etc.",
        error: "Either this offer hasn't specified any payment options, or another error occurred."
      }
      messages[flag.to_sym] || "Either you or #{offer.buyer.name} has yet to login to Campus Bazaar with Venmo, and we are unable to make this transaction."
    end

end
