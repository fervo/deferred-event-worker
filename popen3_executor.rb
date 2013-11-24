require 'open3'

class Popen3Executor
    def initialize(php_path, symfony_console_path)
        @php_path = php_path
        @symfony_console_path = symfony_console_path
    end

    def execute(event_data)
        Open3.popen3("#{@php_path} #{@symfony_console_path} fervo:dispatch #{event_data}") do |stdin, stdout, stderr, wait_thr|
        end
    end

    def cleanup()
    end
end
