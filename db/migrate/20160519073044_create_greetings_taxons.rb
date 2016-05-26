class CreateGreetingsTaxons < ActiveRecord::Migration
  def change
    create_table :spree_greetings_taxons, :id => false do |t|
      t.references :greeting
      t.references :taxon
      t.integer :position
    end

    add_index :spree_greetings_taxons, [:greeting_id], :name => 'index_spree_greetings_taxons_on_greeting_id'
    add_index :spree_greetings_taxons, [:taxon_id],   :name => 'index_spree_greetings_taxons_on_taxon_id'

  end
end
