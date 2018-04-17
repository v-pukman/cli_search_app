require 'json'

module Initech
  class Search
    include Initech::Logger

    def parse_file file_path
      JSON.parse File.read(file_path)
    rescue Errno::ENOENT => e
      logger.error e.message
    rescue JSON::ParserError => e
      logger.error e.message
    end

    def search json_data, key, value
      json_data.select {|i| i[key].to_s == value.to_s }
    end

    def start file_path, key, value
      json_data = parse_file file_path
      search json_data, key, value
    end
  end
end
