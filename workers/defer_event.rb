require_relative '../fastcgi_executor.rb'
require_relative '../popen3_executor.rb'
require 'yaml'
require 'socket'

class DeferEvent
    include Sidekiq::Worker

    @@config = nil

    def self.config()
        if @@config == nil
            @@config = YAML.load_file("config.yaml")
        end

        @@config
    end

    def executor()
        config = DeferEvent.config()

        case config["config"]["type"]
        when 'fastcgi'
            socket = TCPSocket.open config["config"]["connection"]["host"], config["config"]["connection"]["port"]
            return FastcgiExecutor.new socket, config["config"]["dispatcher_path"]
        when 'popen'
            return Popen3Executor.new config["config"]["php_path"], config["config"]["symfony_console_path"]
        end
    end

    def perform(event_data)
        exec = executor()
        exec.execute event_data
        exec.cleanup()
    end
end
