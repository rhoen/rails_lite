require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/core_ext'
require 'erb'
require 'byebug'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)

      controller = self.class.to_s.underscore

      view_contents = File
        .read("views/#{controller}/#{template_name}.html.erb")
      body = ERB.new(view_contents).result(binding)
      content_type = "text/html"
      render_content(body, content_type)



    end
  end
end
