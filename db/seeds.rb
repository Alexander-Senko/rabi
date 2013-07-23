# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

for plugin in [
	RailsDynamicUserRoles,
] do
	plugin::Engine.load_seed
end


# Schema

Rabi::Entity.create [
	{ name: 'User', entity_attributes: [
#		{ name: '', format: '', limit: '', enum: '', required: false, index: '' },
	] },
]
