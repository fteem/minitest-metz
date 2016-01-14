require "minitest/assertions"

module Minitest::Assertions
  def assert_obey_metz(str)
    file_path = full_file_path(str)
    res = Minitest::Metz::Scanner.scan(file_path)
    assert(res.all_valid?, "The class does not obey Sandi Metz' four rules.")
  end

  def refute_obey_metz(str)
    file_path = full_file_path(str)
    res = Minitest::Metz::Scanner.scan(file_path)
    refute(res.all_valid?, "The class obeys Sandi Metz' four rules.")
  end

  private

  def full_file_path(s)
    if s.is_a?(Class)
      where_is(s).first
    else
      s
    end
  end

  def where_is(klass)
    Minitest::Metz::Where.is_class_primarily(klass)
  end
end
