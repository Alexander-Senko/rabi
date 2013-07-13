class Rabi::Entity::Attribute < ActiveRecord::Base
	# IMPORTANT: In order for inheritance to work for the callback queues,
	# you must specify the callbacks before specifying the associations.
	# Otherwise, you might trigger the loading of a child before the parent
	# has registered the callbacks and they won't be inherited.

	after_update do
		# TODO: enable editing of entity attributes
	end

	after_commit do
		Rabi.reload
	end


	belongs_to :entity, readonly: true, inverse_of: :entity_attributes

	validates :name, presence: true, uniqueness: { scope: :entity_id }

	def format_enum
		%w[
			string
			integer
			binary
			boolean
			date
			datetime
			decimal
			float
			text
			time
			timestamp
		]
	end

	def index_enum
		%w[
			index
			uniq
		]
	end

	def to_generator_argument
		name.dup.tap do |arg|
			arg << ":#{format}" if format?
			arg << "{#{limit}}" if format? and limit?
			arg << ":#{index}"  if index?
		end
	end


	def name= value # normalize
		write_attribute :name, value.parameterize('_').
			gsub(/^[^a-z_]+/, '_')
	end
end
