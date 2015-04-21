require 'json'
require 'webrick'
require 'byebug'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)

      find_cookie(req)
      deserialize_cookie
    end

    def deserialize_cookie
      @cookie_object.nil? ? @cookie_value = {} : @cookie_value = JSON.parse(@cookie_object.value)
    end

    def find_cookie(req)
      @cookie_object = req.cookies.find { |cookie| cookie.name == "_rails_lite_app" }
    end

    def [](key)
      @cookie_value[key]
    end

    def []=(key, val)
      @cookie_value[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      res.cookies << WEBrick::Cookie.new("_rails_lite_app", @cookie_value.to_json)
    end
  end
end
