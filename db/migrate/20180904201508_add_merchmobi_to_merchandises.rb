class AddMerchmobiToMerchandises < ActiveRecord::Migration[5.2]
  def change
    add_column :merchandises, :merchmobi, :string
  end
end
