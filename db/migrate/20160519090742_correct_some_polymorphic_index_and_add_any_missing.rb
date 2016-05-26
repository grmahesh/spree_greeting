class CorrectSomePolymorphicIndexAndAddAnyMissing < ActiveRecord::Migration
 def change
   add_index :spree_greeting_option_types, :position
   add_index :spree_greetings, :shipping_category_id
   add_index :spree_greetings, :tax_category_id
 end
end