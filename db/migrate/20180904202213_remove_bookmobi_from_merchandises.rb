class RemoveBookmobiFromMerchandises < ActiveRecord::Migration[5.2]
  def change
    remove_column :merchandises, :bookmobi, :string
  end
end
