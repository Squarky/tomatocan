class RemoveBookepubFromMerchandises < ActiveRecord::Migration[5.2]
  def change
    remove_column :merchandises, :bookepub, :string
  end
end
