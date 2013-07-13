class Rabi::Relation < Relation
	default_scope {
		where source_id: nil,
		      target_id: nil
	}

	# IMPORTANT: In order for inheritance to work for the callback queues,
	# you must specify the callbacks before specifying the associations.
	# Otherwise, you might trigger the loading of a child before the parent
	# has registered the callbacks and they won't be inherited.

	after_commit do
		Rabi.reload
	end


	with_options class_name: 'Rabi::Entity', primary_key: :name do |this|
		this.belongs_to :source_entity, foreign_key: :source_type
		this.belongs_to :target_entity, foreign_key: :target_type
	end

	def entities
		[
			source_entity,
			target_entity,
		].compact
	end


	def self.columns
		super.reject do |column|
			column.name.in? %w[
				source_id
				target_id
			]
		end
	end


	validates_presence_of :source_type,
	                      :target_type


	def human_name
		name.try(:titleize) or
			entities.map(&:human_name) * '-'
	end


	def name= role_name # normalize
		super role_name.parameterize('_').presence
	end
end
