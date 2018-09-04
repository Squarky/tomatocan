class RemoveBookpdfFromMerchandises < ActiveRecord::Migration[5.2]
  def change
    remove_column :merchandises, :bookpdf, :string
  end
end
