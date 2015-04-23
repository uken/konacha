require "tilt"
require "konacha/engine"
require "konacha/runner"
require "konacha/server"
require "konacha/reporter"
require "konacha/formatter"

module Konacha
  class << self
    attr_accessor :mode

    def serve
      puts "Your tests are here:"
      puts "  http://#{host}:#{port}/"
      self.mode = :server
      Konacha::Server.start
    end

    def run
      self.mode = :runner
      Konacha::Runner.start
    end

    def config
      Konacha::Engine.config.konacha
    end

    def configure
      yield config
    end

    delegate :host, :port, :spec_dir, :spec_matcher, :application, :driver, :runner_port, :formatters, :to => :config

    def spec_root
      [config.spec_dir].flatten.map {|d| File.join(Rails.root, d)}
    end

    def spec_paths
      spec_root.flat_map do |root|
        Rails.application.assets.each_file.find_all { |path|
          pathname = Pathname.new(path)
          config.spec_matcher === pathname.basename.to_s &&
          ( pathname.extname == '.js'  ||
            pathname.extname == '.es6' ||
            pathname.extname == '.jsx' ||
            Tilt[pathname])
        }.map { |pathname|
          pathname.to_s.gsub(File.join(root, ''), '')
        }.sort
      end
    end
  end
end
