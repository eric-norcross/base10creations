class RenameRemoteIdToRemoteIp < ActiveRecord::Migration[5.1]
  def change
    rename_column :trackers, :remote_id, :remote_ip
  end
end
