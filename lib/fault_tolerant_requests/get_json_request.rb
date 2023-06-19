require "uri"
class FaultTolerantRequests::GetJsonRequest
    def initialize(proxy_ip = false, user_agent = false, debug = false)
        @proxy_ip = proxy_ip
        @debug = debug
        @user_agent = user_agent
    end

    def do(url, attempts = 15, wait = 15)
        request_count = 0
        while request_count < attempts do
            begin
                options = {}
                options[:proxy] = URI.parse("http://#{@proxy_ip}:3128") if @proxy_ip
                options["User-Agent"] = @user_agent if @user_agent

                requester = ::FaultTolerantRequests::GetRequest
                    .new(
                        @proxy_ip, @user_agent, @debug
                    )
                
                content = requester.do(
                        url, attempts, wait
                    )

                output = ActiveSupport::JSON.decode( content ).deep_symbolize_keys
                
                return output

            rescue JSON::ParserError => p
                puts " --- Attempt #{request_count}: JSON parse error!"
                puts "#{ p.inspect }"
                request_count+= 1
                sleep request_count * wait
            end
        end

        # failed, raise an exception and exit, Rollbar will report
        raise StandardError.new "Exceeded timeout/error count while sending API requests"

    end

end
    

