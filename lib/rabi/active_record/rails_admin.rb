require 'active_support/concern'

module Rabi::ActiveRecord
	module RailsAdmin
		extend ActiveSupport::Concern

		module ClassMethods
			def config
				::RailsAdmin::Config::Model.new self
			end
		end

		def config
			self.class.config.with object: self
		end
	end
end
