require RailsDynamicUserRoles::Engine.root.join('app/models/user/permit')

class User::Permit < ActiveRecord::Base
	rails_admin do
		configure :subject do
			class << self
				def value
					case value = super
						when Class then value.entity
						else            value
					end
				end
			end
		end
	end

	def human_name
		[
			behavior, action, subject && (subject_id ? subject : subject.entity).config.object_label
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

	def subject_type
		super.presence # subject_type == '' leads to subject == Object
	end
end
