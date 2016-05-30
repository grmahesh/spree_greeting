module Spree
	class GreetingDuplicator
    attr_accessor :greeting

		@@clone_greeting_picture_default = true
    mattr_accessor :duplicate_greeting_picture

	def initialize(greeting, include_greeting_picture = @@clone_greeting_picture_default)
      @greeting = greeting
      @include_greeting_picture = include_greeting_picture
    end

    def duplicate
      new_greeting = duplicate_greeting

      # don't dup the actual variants, just the characterising types
      new_greeting.option_types = greeting.option_types if greeting.has_variants?

      # allow site to do some customization
      new_greeting.send(:duplicate_extra, greeting) if new_greeting.respond_to?(:duplicate_extra)
      new_greeting.save!
      new_greeting
    end

    protected

    def duplicate_greeting
      greeting.dup.tap do |new_greeting|
        new_greeting.name = "COPY OF #{greeting.name}"
        new_greeting.taxons = product.taxons
        new_greeting.created_at = nil
        new_greeting.deleted_at = nil
        new_greeting.updated_at = nil
        new_greeting.master = duplicate_master
        new_greeting.variants = greeting.variants.map { |variant| duplicate_variant variant }
      end
    end

    def duplicate_master
      master = greeting.master
      master.dup.tap do |new_master|
        new_master.sku = "COPY OF #{master.sku}"
        new_master.deleted_at = nil
        new_master.greeting_picture = master.greeting_picture if include_greeting_picture
        new_master.price = master.price
        new_master.currency = master.currency
      end
    end

    def duplicate_variant(variant)
      new_variant = variant.dup
      new_variant.sku = "COPY OF #{new_variant.sku}"
      new_variant.deleted_at = nil
      new_variant.option_values = variant.option_values.map { |option_value| option_value}
      new_variant
    end

		def duplicate_greeting_picture(greeting_picture)
      new_greeting_picture = greeting_picture.dup
      new_greeting_picture.assign_attributes(:attachment => greeting_picture.attachment.clone)
      new_greeting_picture
    end
  end
end
