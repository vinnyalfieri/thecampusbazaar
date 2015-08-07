class ChangeOfferStatusDefault < ActiveRecord::Migration
  def change
    change_column_default :offers, :status, "pending"
  end
end
