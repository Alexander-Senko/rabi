class User < ActiveRecord::Base
	def name
		name = email.split('@').first and
			case (name.gsub('.', ' ')).size
				when 2..3 then name.upcase
				else           name.titleize
			end
	end unless table_exists? and 'name'.in? column_names
end
