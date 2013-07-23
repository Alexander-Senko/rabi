ActiveSupport.on_load :model_class do
	for attribute in entity_attributes do
		validates_presence_of attribute.name if attribute.required?

		-> enum {
			define_method "#{attribute.name}_enum" do
				case options = YAML.load(enum)
					when String then enum.lines.map &:strip
					else options.to_a
				end
			end
		}.(attribute.enum) if attribute.enum.present?
	end if entity_attributes
end
