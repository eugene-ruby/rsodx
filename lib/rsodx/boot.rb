module Rsodx
  module Boot
    def self.load_app_structure(app_root)
      %w[models interactors presenters serializers api].each do |folder|
        path = File.join(app_root, "app", folder)
        $LOAD_PATH.unshift(path) if Dir.exist?(path)
        Dir["#{path}/**/*.rb"].sort.each { |file| require file }
      end
    end
  end
end
