class CreateRabiEntityAttributes < ActiveRecord::Migration
	def change
		create_table :rabi_entity_attributes do |t|
			t.references :entity, null: false
			t.string     :name,   null: false
			t.string     :format
			t.integer    :limit
			t.text       :enum
			t.boolean    :required
			t.string     :index

			t.timestamps
		end
	end
end
