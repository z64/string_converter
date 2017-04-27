require "./string_converter/*"

# A container for converters that handle converting Strings into
# numeric types. For use in JSON.mapping and YAML.mapping.
module StringConverter
  {% for typ in [Int8, UInt8, Int16, UInt16, Int32, UInt32, Int64, UInt64, Float32, Float64] %}
    class {{typ}}
      def self.from_json(parser) : ::{{typ}} | Nil
        str = parser.read_string_or_null
        return nil unless str

        ::{{typ}}.new str.as(String)
      rescue ArgumentError
        nil
      end

      def self.from_yaml(parser) : ::{{typ}} | Nil
        str = parser.read_raw

        ::{{typ}}.new str
      rescue ArgumentError
        nil
      end
    end
  {% end %}
end
