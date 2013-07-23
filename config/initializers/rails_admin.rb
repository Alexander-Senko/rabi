RailsAdmin.config do |config|
	# Set the admin name here (optional second array element will appear in red).
	config.main_app_name = -> controller {
		[
			Rails.application.engine_name, controller.action_name
		].map &:titleize
	}

	# RailsAdmin may need a way to know who the current user is]
	config.current_user_method { current_user } # auto-generated

	# If you want to track changes on your models:
	# config.audit_with :history, 'User'

	# Or with a PaperTrail: (you need to install it first)
	# config.audit_with :paper_trail, 'User'

	# Display empty fields in show views:
	# config.compact_show_view = false

	# Number of default rows per-page:
	# config.default_items_per_page = 20

	# Exclude specific models (keep the others):
	# config.excluded_models = [
	#   'Rabi::Entity', 'Rabi::Entity::Attribute', 'Rabi::Relation', 'Relation', 'Role'
	# ]

	# Include specific models (exclude the others):
	# config.included_models = [
	#   'Rabi::Entity', 'Rabi::Entity::Attribute', 'Rabi::Relation', 'Relation', 'Role'
	# ]

	# Label methods for model instances:
	# config.label_methods << :description # Default is [:name, :title]
end
