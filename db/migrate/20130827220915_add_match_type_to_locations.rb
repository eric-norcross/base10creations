class AddMatchTypeToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :match_type, :string
  end
end
