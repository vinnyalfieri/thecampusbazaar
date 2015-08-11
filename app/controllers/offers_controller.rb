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
  end

  def accepted
    offer = Offer.find(params[:id])
    offer.status = 'accepted'
    if offer.charge_venmo
      flash[:notice] = "venmo charged!"
      offer.save
      reject_offers(offer.item_id)
    else
      flash[:notice] = "One of you needs to get Venmo"
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
