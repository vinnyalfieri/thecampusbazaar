class OffersController < ApplicationController

  def new 
    @user = User.find(params[:user])  #seller of the item 
    @item = Item.find(params[:item])  #item the offer is about
  end 

  def create
    offer = Offer.create(seller_id: Item.find(params[:item]).seller_id, buyer: current_user, item_id: params[:item], offer_price: params[:offer_price], comment: params[:comment], status: 'pending')
    flash[:notice] = "Offer has been submitted!"
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
    case offer.charge_venmo
    when "settled"
      flash[:notice] = "You have successfully charged #{offer.buyer.name} for #{offer.offer_price}!"
      offer.status = 'accepted'
      offer.save
      reject_offers(offer.item_id)
    when "pending"
      flash[:notice] = "A charge request has been sent to #{offer.buyer.name}. They will need to accept your Venmo charge manually."
    when "failed"
      flash[:notice] = "Charging #{offer.buyer.name} was unsuccessful. Contact them for more info."
    when false
      flash[:notice] = "Either you or #{offer.buyer.name} has yet to login to Campus Bazaar with Venmo, and we are unable to make this transaction."
    end
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
  def reject_offers(item_id)
    offers = Offer.pending_offers(item_id)
    offers.each do |offer|
      offer.status = 'rejected'
      offer.save
    end 
  end 

end
