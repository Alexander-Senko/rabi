class Rabi::Entity < ActiveRecord::Base
	# IMPORTANT: In order for inheritance to work for the callback queues,
	# you must specify the callbacks before specifying the associations.
	# Otherwise, you might trigger the loading of a child before the parent
	# has registered the callbacks and they won't be inherited.

	after_create do
		Rabi.generate :model, name, *entity_attributes.map(&:to_generator_argument)
		Rabi.migrate
	end

	after_update do
		# TODO: enable editing of entity
	end

	after_destroy do
		Rabi.destroy :model, name
	end

	after_commit do
		Rabi.reload
	end

	# TODO: handle batches
	{ add: 'to', remove: 'from' }.each &proc { |action, prep|
		define_method "after_#{action}_attribute" do |attribute|
			return if new_record?

			Rabi.generate :migration, [ action, attribute.name, prep, name ] * '_', attribute.to_generator_argument
			Rabi.migrate
		end
	}


	has_many :entity_attributes, class_name: 'Rabi::Entity::Attribute', inverse_of: :entity,
		after_add: :after_add_attribute, after_remove: :after_remove_attribute, dependent: :delete_all

	accepts_nested_attributes_for :entity_attributes,
		reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true


	def self.model_names
		pluck :name
	end


	validates :name, presence: true, uniqueness: true


	def human_name
		model &&
			model.model_name.human
	end

	def model
		name.try :constantize
	end


	def name= value # normalize
		write_attribute :name, Russian.transliterate(value).
			gsub(/\s+/, '_').classify.gsub(/(^[^a-z_]+|[^a-z0-9_]+)/i, '')
	end
end
