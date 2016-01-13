module Minitest
  def self.plugin_metz_options(opts, options)
    opts.on "-z", "--metz" do |z|
      options[:metz] = z
    end
  end

end
