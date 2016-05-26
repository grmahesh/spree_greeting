class CreateGreetingOptionTypes < ActiveRecord::Migration
  def change
    create_table :spree_greeting_option_types do |t|
      t.integer    :position
      t.references :greeting
      t.references :option_type
      t.timestamps null: false
    end
  end
end
