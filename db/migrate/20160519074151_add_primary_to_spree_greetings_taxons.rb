class AddPrimaryToSpreeGreetingsTaxons < ActiveRecord::Migration
  def change
    add_column :spree_greetings_taxons, :id, :primary_key
  end
end
