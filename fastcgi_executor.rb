require 'socket'
load 'fastcgi.rb'

class FastcgiExecutor
    def initialize(socket, dispatcher)
        @fastcgi_socket = FastCGISocket.new socket
        @dispatcher = dispatcher
        @random = Random.new
    end

    def cleanup()
        @fastcgi_socket.close()
    end

    def execute(event_data)
        request_id = @random.rand(10000)

        beg = BeginRequestRecord.new request_id, FCGI_RESPONDER, 0
        params = ParamsRecord.new request_id, {
            'SCRIPT_FILENAME' => @dispatcher,
            'REQUEST_METHOD' => 'POST',
            'DEFERRED_DATA' => event_data
        }
        stdin = StdinDataRecord.new request_id, ''

        @fastcgi_socket.send_record beg
        @fastcgi_socket.send_record params
        @fastcgi_socket.send_record stdin

        stdout_buf = ''
        stderr_buf = ''

        loop do
            rec = @fastcgi_socket.read_record

            case rec.type
            when FCGI_END_REQUEST
                if rec.application_status != 0
                    raise StandardError, stderr_buf
                end
                break
            when FCGI_STDOUT
                stdout_buf << rec.flagment
            when FCGI_STDERR
                stderr_buf << rec.flagment
            else
                raise "got unknown record: #{rec.class}"
            end
        end

#        puts stdout_buf
    end
end
