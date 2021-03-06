class ImportParser
  module Strategies
    class CSV
      def parse(string)
        string.force_encoding('UTF-8')
        rows = ::CSV.parse(string, headers: true)
        {
          headers: rows.headers,
          rows: rows.map(&:to_hash)
        }
      rescue ::CSV::MalformedCSVError => e
        {
          error: e.message
        }
      end
    end
  end
end
