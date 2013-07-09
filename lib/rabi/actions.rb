require 'active_support/concern'
require 'rails/generators'

module Rabi::Actions
	extend ActiveSupport::Concern

	included do
		this = self

		ActiveSupport.on_load :action_controller do
			after_filter do
				this.perform_pending_actions
			end
		end
	end

	module ClassMethods
		def generate what, *args
			generator.generate what, *args, '--force'
		end

		def destroy what, *args
			# TODO: don't copy-paste Rails::Generators::Actions#generate
			generator.instance_exec self do
				log :generate, what
				argument = args.map { |arg| arg.to_s }.flatten.join(' ')

				in_root { run_ruby_script("bin/rails destroy #{what} #{argument}", verbose: false) }
			end
		end

		def migrate!
			generator.rake 'db:migrate'
		end

		def reload!
			FileUtils.touch Rails.root.join(*%w[ tmp restart.txt ]) # for Passenger
		end

		(PENDING_ACTIONS = %w[ migrate reload ]).each &proc { |action|
			define_method action do
				instance_variable_set "@#{action}", true
			end
		}


		def perform_pending_actions
			for action in PENDING_ACTIONS do
				send "#{action}!" if instance_variable_get "@#{action}"
				instance_variable_set "@#{action}", false
			end
		end

		private

		def generator
			@generator ||= Rails::Generators::Base.new
		end
	end
end
