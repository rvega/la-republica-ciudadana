class AddConfirmableToUsers < ActiveRecord::Migration
  def up
    add_column :usuarios, :confirmation_token, :string
    add_column :usuarios, :confirmed_at, :datetime
    add_column :usuarios, :confirmation_sent_at, :datetime
    add_column :usuarios, :unconfirmed_email, :string 
    add_index :usuarios, :confirmation_token, :unique => true
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # usuarios as confirmed, do the following
    Usuario.update_all(:confirmed_at => Time.now)
    # All existing user accounts should be able to log in after this.
  end

  def down
    remove_column :usuarios, :confirmation_token, :confirmed_at, :confirmation_sent_at
    remove_column :usuarios, :unconfirmed_email 
  end
end
