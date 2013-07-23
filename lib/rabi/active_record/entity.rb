require 'active_support/concern'

module Rabi::ActiveRecord
	module Entity
		extend ActiveSupport::Concern

		module ClassMethods
			def entity
				@entity ||= Rabi::Entity.find_by_name name if
					Rabi::Entity.table_exists? # needed for DB migrations & schema initializing
			end

			def entity_attributes
				@entity_attributes ||= entity.try :entity_attributes
			end
		end
	end
end
