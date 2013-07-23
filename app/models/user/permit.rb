class User::Permit < ActiveRecord::Base
	belongs_to :subject_entity, inverse_of: :permits,
		foreign_key: :subject_type, class_name: 'Rabi::Entity', primary_key: :name

	def human_name
		[
			behavior, action, subject && subject.config.object_label
		].compact * ' '
	end

	def action_enum_with_rabi
		action_enum_without_rabi + %w[
			export
			history
			show_in_app
		]
	end

	alias_method_chain :action_enum, :rabi
end
