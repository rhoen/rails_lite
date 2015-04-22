require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    attr_accessor :params

    def initialize(req, route_params = {})
      @req = req
      @route_params = route_params
      @params = {}
      parse_www_encoded_form(@req.query_string)
    end

    def [](key)
      params[key.to_s]
    end

    def to_s
      params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      return if www_encoded_form.nil?
      query_pairs = URI::decode_www_form(www_encoded_form)

      query_pairs.each do |pair|
        keys = parse_key(pair[0])
        query_value = pair[1]
        if keys.size == 1
          params[keys[0]] = query_value
          next
        end
        params[keys.shift] = nest_hashes(keys, query_value)
      end
      first_nested_query = query_pairs[0][0]
      split = first_nested_query.split(/\]\[|\[|\]/)

    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end

    def nest_hashes(key_arr, val)
      if key_arr.size == 1
        return {key_arr[0] => val}
      end
      {key_arr[0] => nest_hashes(key_arr[1..-1], val)}
    end
  end
end
