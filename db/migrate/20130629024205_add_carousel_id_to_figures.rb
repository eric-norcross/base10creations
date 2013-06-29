class AddCarouselIdToFigures < ActiveRecord::Migration
  def change
    add_column :figures, :carousel_id, :integer
  end
end
