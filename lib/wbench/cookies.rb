module WBench
  class Cookies
    def self.set(session, url, cookie_string)
      new(session, url, cookie_string).set
    end

    private_class_method :new

    def initialize(session, url, cookie_string)
      @session       = session
      @url           = url
      @cookie_string = cookie_string
    end

    def set
      if cookies
        add_cookies
      end
    end

    private

    def cookies
      return @cookies if defined?(@cookies)

      if @cookie_string
        @cookies = @cookie_string.split(/;\s/).map do |line|
          { :name => line.split('=')[0], :value => line.split('=')[1] }
        end
      end
    end

    def add_cookies
      visit_cookie_domain
      delete_existing_cookies
      add_new_cookies
    end

    def visit_cookie_domain
      @session.visit(cookie_domain)
    end

    def delete_existing_cookies
      @session.driver.browser.manage.delete_all_cookies
    end

    def add_new_cookies
      cookies.each do |cookie|
        @session.driver.browser.manage.add_cookie(cookie)
      end
    end

    def cookie_domain
      Addressable::URI.parse(@url).tap { |uri| uri.path = '' }.normalize.to_s
    end
  end
end
