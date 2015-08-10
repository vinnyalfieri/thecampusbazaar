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
    @available_items = current_user.items.select{|item| item.status == 'available'}
    @sold_items = current_user.items.select{|item| item.status == 'sold'}
    # get the received offers for the current user
    # organize the show page to show ALL offers per product. Group by a specific product. SO each item will have a list of Pending, Rejected, and Accepted offers.
    # add an ACCEPT and REJECT button to the PENDING offers ONLY if there is NO accepted offers for that item.
    # When offer is accepted. ALL other offers for that item are REJECTED.
    #show a table. ACCEPTED offer on TOP highlighted in GREEN
    #the REJECTED offer will drop to the bottom of the table.
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

  def destroy
    Offer.destroy(params[:id])
    redirect_to offers_sent_path
  end

  private
  def reject_offers(item_id)
    #go through all pending offers with that item id and reject
    offers = Offer.pending_offers(item_id)
    offers.each do |offer|
      offer.status = 'rejected'
      offer.save
    end 
  end 

end
