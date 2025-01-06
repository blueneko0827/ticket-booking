class AddLockVersionToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :lock_version, :integer
  end
end
