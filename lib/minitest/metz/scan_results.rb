module Minitest
  module Metz

    class ScanResults
      attr_reader :first_rule, :misindentation, :second_rule, :third_rule

      def initialize(results)
        @first_rule = results[:first_rule][:total_classes_amount] - results[:first_rule][:small_classes_amount]
        @misindentation = results[:first_rule][:misindented_classes_amount]
        @second_rule =  results[:second_rule][:total_methods_amount] - results[:second_rule][:small_methods_amount]
        @third_rule = results[:third_rule][:total_method_calls] - results[:third_rule][:proper_method_calls]
      end

      def all_valid?
        first_rule_valid? && misidentation_valid? && second_rule_valid? && third_rule_valid?
      end

      def first_rule_valid?
        first_rule.zero?
      end

      def misidentation_valid?
        misindentation.zero?
      end

      def second_rule_valid?
        second_rule.zero?
      end

      def third_rule_valid?
        third_rule.zero?
      end
    end

  end
end
