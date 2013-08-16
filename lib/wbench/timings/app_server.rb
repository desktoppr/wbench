module WBench
  module Timings
    class AppServer
      def initialize(browser)
        @browser = browser
      end

      def result
        response = http.request(request)

        unless response.header['x-runtime'].nil?
          (response.header['x-runtime'].to_f * 1000).to_i
        end
      end

      private

      def uri
        Addressable::URI.parse(@browser.url)
      end

      def http
        Net::HTTP.new(uri.host, uri.inferred_port).tap do |http|
          http.use_ssl = uri.scheme == 'https'
        end
      end

      def request
        Net::HTTP::Get.new(uri.request_uri)
      end
    end
  end
end
