require 'rabi/active_record/entity'
require 'rabi/active_record/rails_admin'

ActiveSupport.on_load :active_record do
	include Rabi::ActiveRecord::Entity
	include Rabi::ActiveRecord::RailsAdmin
end
