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
  end

  def sent
  end

  def received
    @available_items = current_user.items.select{|item| item.available?}
    @sold_items = current_user.items.reject{|item| item.available?}
  end

  def accepted
    offer = Offer.find(params[:id])
    offer.status = 'accepted'
    offer.save
    reject_offers(offer.item_id)
    redirect_to offers_received_path 
  end 

  def rejected
    offer = Offer.find(params[:id])
    offer.status = 'rejected'
    offer.save
    redirect_to offers_received_path
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
