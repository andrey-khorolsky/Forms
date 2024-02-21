class PankoGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  argument :attributes, type: :array, default: []

  def create_initializer_file
    create_file "app/serializers/#{name.downcase}_serializer.rb", <<~TEXT
      class #{name.capitalize}Serializer < Panko::Serializer
        #{print_attrs}
      end
    TEXT
  end

  def print_attrs
    return if attributes.blank?
    res = "attributes #{attributes.map { ":#{_1.name}" }.join(", ")}"

    defs = attributes.select { name.capitalize.constantize.column_names.exclude?(_1.name) }.map(&:name)

    return res if defs.blank?

    defs.each do |atr|
      res += "\n\n  def #{atr}\n  end"
    end
    res
  end
end
