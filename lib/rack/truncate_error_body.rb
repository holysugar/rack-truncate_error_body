require "rack/truncate_error_body/version"

module Rack
  class TruncateErrorBody
    def initialize(app, options = {})
      @app = app
      @options = options
    end

    def call(env)
      res = @app.call(env)
      type = @options[:content_type] || "text/plain"
      if (!@options[:only_cascaded] || res[1]["X-Cascade"] == "pass") && res[0] >= 400
        [res[0], {"Content-Type" => type}, []]
      else
        res
      end
    end
  end
end
