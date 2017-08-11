class RenameDomainToRemoteIp < ActiveRecord::Migration[5.1]
  def change
    rename_column :trackers, :domain, :remote_id
  end
end
