class AddMerchpdfToMerchandises < ActiveRecord::Migration[5.2]
  def change
    add_column :merchandises, :merchpdf, :string
  end
end
