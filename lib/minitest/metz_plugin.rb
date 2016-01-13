module Minitest
  def self.plugin_metz_options(opts, options)
    opts.on "-z", "--metz" do |z|
      options[:metz] = z
    end
  end

  def self.plugin_metz_init(options)
    if options[:metz]
      self.reporter << Minitest::Metz::StatsReporter.new(options[:io], options)
    end
  end
end
