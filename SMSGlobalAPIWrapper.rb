# SMS GLobal
# http://smsglobal.com
# @author Huy Dinh <huy.dinh@smsglobal.com>

require "date"
require "time"
require "openssl"
require "base64"
require "digest"
require "net/http"

class SMSGlobalAPIWrapper

    def initialize(key, secret, protocol = "http", host = "api.smsglobal.com", port = "80", apiVersion = "v1", extraData = "", debug = false)
        @key = key
        @secret = secret
        @protocol = protocol.downcase
        @host = host
        @port = port
        @apiVersion = apiVersion
        @extraData = extraData
        @debug = debug
    end

    def get(action, id = nil)
        return connect("GET", action, id)
    end

    def post(action, id = nil)
        return connect("POST", action, id)
    end

    def delete(action, id = nil)
        return connect("DELETE", action, id)
    end

    private

        def connect(method, action, id = nil)
            action = "/#{action}"
            unless id.nil? || id == '' || id < 0
                action = "#{action}/id/#{id}"
            end

            uri = URI.parse(%Q{#{@protocol}://#{@host}:#{@port}/#{@apiVersion}#{action}})

            # Set up request metadata
            case method
                when "POST"
                    request = Net::HTTP::Post.new(uri.path)
                when "GET"
                    request = Net::HTTP::Get.new(uri.path)
                when "DELETE"
                    request = Net::HTTP::Delete.new(uri.path)
                else #use GET
                    request = Net::HTTP::Get.new(uri.path)
            end
            request["Authorization"] = getAuthorisationHTTPHeader(method, action)

            # HTTP transportation
            http = Net::HTTP.new(uri.host, uri.port)

            if @protocol == "https" then
                http.use_ssl = true
            end

            if @debug then
                http.set_debug_output($stdout)
            end

            # do it!
            response = http.request(request)

            unless !response.is_a?(Net::HTTPSuccess) then
                return response.body
            else
                raise "There's problem accessing API"
            end;
        end

        def getAuthorisationHTTPHeader(method, action)
            algorithm = "sha256"

            # Get current Time
            timestamp = Time.now.to_i

            # Random String
            nonce = Digest::MD5.hexdigest((rand(36**7...36**8).to_s(36)))

            # Hence
            rawStr = "#{timestamp}\n#{nonce}\n#{method}\n/#{@apiVersion}#{action}\n#{@host}\n#{@port}\n#{@extraData}\n"

            # Encryptions
            shaDigest = OpenSSL::Digest::Digest.new("sha256")
            hash = OpenSSL::HMAC.digest(shaDigest, @secret, rawStr)
            hash = Base64::strict_encode64(hash);

            mac = "MAC id=\"%s\",ts=\"%s\",nonce=\"%s\",mac=\"%s\"" % [@key, timestamp, nonce, hash]

            return mac
        end
end


