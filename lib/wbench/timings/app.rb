module WBench
  module Timings
    class App
      def initialize(url)
        uri = URI.parse(url)
        @http = Net::HTTP.new(uri.host, uri.port)
        @http.use_ssl = uri.scheme == 'https'
        @request = Net::HTTP::Get.new(uri.request_uri)
      end

      def result
        response = @http.request(@request)

        (response.header['x-runtime'].to_f*1000).to_i
      end
    end
  end
end
