class AddMerchepubToMerchandises < ActiveRecord::Migration[5.2]
  def change
    add_column :merchandises, :merchepub, :string
  end
end
