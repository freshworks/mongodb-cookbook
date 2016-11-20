# MongoDBConfigHelpers provides helpers to remove rendering logic
# from templates
module MongoDBConfigHelpers
  # to_boost_program_options takes a config Hash (with string keys and
  # scalar values) and converts to the boost::program_options format
  # used by mongodb 2.4.
  #
  # Notably it:
  # - ensures consistent ordering by key name
  # - does not render entries with a value of nil or ''
  def to_boost_program_options(config)
    config.sort
    .map do |key, value|
      next if value.nil? || value == ''
      "#{key} = #{value}"
    end
    .compact
    .join("\n")
  end
  
  def to_yaml_options(config)
    require 'yaml'
    puts config
    hash = Hash.new
    config.sort.each do |key, value|
      next if value.nil? || value == ''
      if value.kind_of?(Hash)
        value.each do |nestedKey, nestedValue|
          #puts "nested val #{nestedKey} #{nestedValue}"
          next if nestedValue.nil? || nestedValue == ''
          hash[key] ||= {}
          hash[key][nestedKey] = nestedValue
        end
      else
        hash[key] = value
      end
    end
    JSON.parse(hash.to_json).to_yaml
  end
end
