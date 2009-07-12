class AddIsApprovedToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :is_approved, :integer, :default => 0
  end

  def self.down
    remove_column :messages, :is_approved
  end
end
