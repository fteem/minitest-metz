require 'test_helper'

class Minitest::AssertionsTest < Minitest::Test
  def test_that_it_obeyz_metz_rules
    assert_obey_metz("test/minitest/metz_test.rb")
  end
end
