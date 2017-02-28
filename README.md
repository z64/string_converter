# string_converter

A collection of converters for use in `JSON.mapping` and `YAML.mapping` to convert
numeric types represented as Strings. Essentially just removes the boilerplate of doing so yourself.

Useful for writing data objects for APIs that only return string value types in their fields for numerics.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  string_converter:
    github: z64/string_converter
```

## Usage

Each converter will return `T | Nil` in order to rescue from bad data. You must specify `T?` in your mapping, or use `nilable: true`.

```crystal
require "json"
require "yaml"
require "string_converter"

data = {test: "1", value: "3.5", bad: "1abc23"}
json_string = data.to_json #=> String
yaml_string = data.to_yaml #=> String

class Data
  macro mapping(mapper)
    {{mapper}}.mapping({
      test: {type: Int8?, converter: StringConverter::Int8},
      value: {type: Float32?, converter: StringConverter::Float32},
      bad: {type: Float64?, converter: StringConverter::Float64},
    })
  end

  mapping JSON
  mapping YAML
end

puts Data.from_json(json_string).inspect #=> #<Data:0x.. @test=1, @value=3.5, @bad=nil>
puts Data.from_yaml(yaml_string).inspect #=> #<Data:0x.. @test=1, @value=3.5, @bad=nil>
```

## Contributors

- [z64](https://github.com/z64) Zac Nowicki - creator, maintainer
