require "sandi_meter/file_scanner"

module Minitest
  module Metz
    class Scanner
      def self.scan(file_path)
        new.scan(file_path)
      end

      def initialize
        @scanner = SandiMeter::FileScanner.new
      end

      def scan(file_path)
        r = @scanner.scan(file_path)
        Minitest::Metz::ScanResults.new(r)
      end

    end
  end
end
