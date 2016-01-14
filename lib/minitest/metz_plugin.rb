require 'pp'
require "minitest"

module Minitest
  def self.plugin_metz_options(opts, options)
    opts.on "-z", "--metz", "Check if your code obeys Sandi Metz' four rules for developers" do |z|
      options[:metz] = z
    end
  end

  def self.plugin_metz_init(options)
    if options[:metz]
      self.reporter << Minitest::Metz::StatsReporter.new
    end
  end
end
