require "minitest"
require 'sandi_meter/file_scanner'

module Minitest
  module Metz

    class StatsReporter < Minitest::Reporter
      def initialize
        @scanner = SandiMeter::FileScanner.new
        @results = {}
      end

      def record(result)
        file_path, = result.class.instance_method(result.name).source_location
        unless @results[file_path]
          r =  @scanner.scan(file_path)
          @results[file_path] = build_results_string(file_path, r)
        end
      end

      def report
        @results.each do |key, output|
          puts output
        end
      end

      private

      def build_results_string(file_path, results)
        "\nSandi Meter Rules results:\n"\
        "#{file_path}"\
        "\n  #{first_rule_metric(results)} class(es) over 100 lines."\
        "\n  #{misindentation_rule_metric(results)} misindented class(es)."\
        "\n  #{second_rule_metric(results)} method(s) over 5 lines."\
        "\n  #{third_rule_metric(results)} method call(s) accepted are more than 4 parameters."
      end

      def first_rule_metric(results)
        results[:first_rule][:total_classes_amount] - results[:first_rule][:small_classes_amount]
      end

      def misindentation_rule_metric(results)
        results[:first_rule][:misindented_classes_amount]
      end

      def second_rule_metric(results)
        results[:second_rule][:total_methods_amount] - results[:second_rule][:small_methods_amount]
      end

      def third_rule_metric(results)
        results[:third_rule][:total_method_calls] - results[:third_rule][:proper_method_calls]
      end
    end

  end
end
