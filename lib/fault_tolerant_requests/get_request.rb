require "uri"
class FaultTolerantRequests::GetRequest
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

                puts options if @debug
                puts " + #{url} (#{request_count})" if @debug

                output = URI.open(url, options).read

                puts output if @debug

                # request went through fine
                return output
            rescue OpenURI::HTTPError => p
                puts " --- Attempt #{request_count}: HTTP error!"
                puts "#{ p.inspect }"
                request_count+= 1
                sleep request_count * wait * 2

            rescue Net::ReadTimeout, Net::OpenTimeout, EOFError => e
                # timeout/eof occured, log and sleep
                puts " --- Attempt #{request_count}: timeout error!"
                puts "#{e.inspect}"
                request_count+= 1
                sleep request_count * wait

            rescue OpenSSL::SSL::SSLError => n
                # SSL certificate error
                puts " --- Attempt #{request_count}: SSL error!"
                puts "#{e.inspect}"
                request_count+= 1
                sleep request_count * wait

            end
        end

        # failed, raise an exception and exit, Rollbar will report
        raise StandardError.new "Exceeded timeout/error count while sending API requests"

    end

end
    
