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
  end
end
