class CreateRabiEntities < ActiveRecord::Migration
	def change
		create_table :rabi_entities do |t|
			t.string :name, null: false

			t.timestamps
		end
	end
end
