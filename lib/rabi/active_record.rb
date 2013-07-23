require 'rabi/active_record/rails_admin'

ActiveSupport.on_load :active_record do
	include Rabi::ActiveRecord::RailsAdmin
end
