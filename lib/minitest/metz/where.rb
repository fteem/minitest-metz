module Minitest
  module Metz
    module Where
      class << self
        def is_class(klass)
          methods = defined_methods(klass)
          file_groups = methods.group_by{|sl| sl[0]}
          file_counts = file_groups.map do |file, sls|
            lines = sls.map{|sl| sl[1]}
            count = lines.size
            line = lines.min
            {file: file, count: count, line: line}
          end
          file_counts.sort_by!{|fc| fc[:count]}
          source_locations = file_counts.map{|fc| [fc[:file], fc[:line]]}
          source_locations
        end

        # Raises ArgumentError if klass does not have any Ruby methods defined in it.
        def is_class_primarily(klass)
          source_locations = is_class(klass)
          if source_locations.empty?
            methods = defined_methods(klass)
            raise ArgumentError, (methods.empty? ?
                                  "#{klass} has no methods" :
                                  "#{klass} only has built-in methods (#{methods.size} in total)"
                                 )
          end
          source_locations[0]
        end

        private

        def source_location(method)
          method.source_location || (
            method.to_s =~ /: (.*)>/
            $1
          )
        end

        def defined_methods(klass)
          methods = klass.methods(false).map{|m| klass.method(m)} +
            klass.instance_methods(false).map{|m| klass.instance_method(m)}
          methods.map!(&:source_location)
          methods.compact!
          methods
        end
      end

    end
  end
end

