require "fileutils"

module Rsodx::Cli
  class Generator
    ROOT_MAP = {
      controller: "app/controllers",
      presenter:  "app/presenters",
      serializer: "app/serializers"
    }

    SUFFIX_MAP = {
      controller: "Controller",
      presenter:  "Presenter",
      serializer: "Serializer"
    }

    def self.generate(type, args)
      path = args[:path]
      type = type.to_sym
      raise "Unknown type: #{type}" unless ROOT_MAP.key?(type)

      segments     = path.split("/")
      file_name    = segments.pop
      file_path    = "#{ROOT_MAP[type]}/#{segments.join("/")}/#{file_name}_#{type}.rb"
      namespace    = segments.map { |seg| camelize(seg) }.join("::")
      class_name   = "#{camelize(file_name)}#{SUFFIX_MAP[type]}"
      full_class   = [namespace, class_name].reject(&:empty?).join("::")

      FileUtils.mkdir_p(File.dirname(file_path))
      File.write(file_path, template(full_class, type))

      puts "✅ Created #{file_path}"
    end

    def self.camelize(str)
      str.split(/[_-]/).map { |part| part.capitalize }.join
    end

    def self.template(full_class, type)
      base_class = {
        controller: "AppController",
        presenter:  "AppPresenter",
        serializer: "AppSerializer"
      }[type]

      namespace = full_class.split("::")[0..-2].join("::")
      class_name = full_class.split("::").last

      <<~RUBY
        module #{namespace}
          class #{class_name} < #{base_class}
            def call
              # TODO: implement
            end
          end
        end
      RUBY
    end
  end
end
