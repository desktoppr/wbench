module WBench
  module Timings
    class AppServer
      def initialize(browser)
        uri = URI.parse(browser.url)
        @http = Net::HTTP.new(uri.host, uri.port)
        @http.use_ssl = uri.scheme == 'https'
        @request = Net::HTTP::Get.new(uri.request_uri)
      end

      def result
        response = @http.request(@request)

        unless response.header['x-runtime'].nil?
          (response.header['x-runtime'].to_f*1000).to_i
        end
      end
    end
  end
end
