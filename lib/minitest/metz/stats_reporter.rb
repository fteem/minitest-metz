require "minitest"

module Minitest
  module Metz

    class StatsReporter < Minitest::Reporter
      def initialize
        @scanner = Minitest::Metz::Scanner.new
        @results = {}
      end

      def record(result)
        file_path, = result.class.instance_method(result.name).source_location
        unless @results[file_path]
          scan_result = Minitest::Metz::Scanner.scan(file_path)
          @results[file_path] = build_results_string(file_path, scan_result)
        end
      end

      def report
        @results.each do |key, output|
          puts output
        end
      end

      private

      def build_results_string(file_path, result)
        str = "\nSandi Meter Rules results:"
        if result.all_valid?
          str << " All valid."
        else
          str << "\n#{file_path}"
          str << "\n  #{result.first_rule} class(es) over 100 lines." unless result.first_rule_valid?
          str << "\n  #{result.misidentation} misindented class(es)." unless result.misidentation_valid?
          str << "\n  #{result.second_rule} method(s) over 5 lines." unless result.second_rule_valid?
          str << "\n  #{result.third_rule} method call(s) accepted are more than 4 parameters." unless result.third_rule_valid?
        end

        str
      end

    end
  end
end
