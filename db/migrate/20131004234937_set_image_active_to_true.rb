class SetImageActiveToTrue < ActiveRecord::Migration
  def change
     Image.connection.execute("update images set active=true")
  end
end
