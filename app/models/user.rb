class User < ActiveRecord::Base
	def name
		case (name = email.split('@').first.gsub('.', ' ')).size
			when 2..3 then name.upcase
			else           name.titleize
		end
	end unless table_exists? and 'name'.in? column_names
end
