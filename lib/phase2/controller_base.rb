module Phase2
  class ControllerBase
    attr_reader :req, :res

    # Setup the controller
    def initialize(req, res)
      @req = req
      @res = res
    end

    # Helper method to alias @already_built_response
    def already_built_response?
      @already_built_response ||= false
    end

    # Set the response status code and header
    def redirect_to(url)
      @res.status = 302
      @res["location"] = url
      @already_built_response = true
      # @res.set_redirect(WEBrick::HTTPStatus::Redirect, url)
    end

    # Populate the response with content.
    # Set the response's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(content, content_type)
      raise "already rendered" if already_built_response?
      @already_built_response = true
      @res.body = content
      @res.content_type = content_type
    end
  end
end
