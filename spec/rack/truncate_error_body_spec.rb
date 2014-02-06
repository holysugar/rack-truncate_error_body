require 'spec_helper'

class RackApp
  def initialize(status, x_cascade = true)
    @status    = status
    @x_cascade = x_cascade
  end

  def call(env)
    headers = {}
    headers["X-Cascade"] = "pass" if @x_cascade
    [@status, headers, ["Not Found"]]
  end
end

describe Rack::TruncateErrorBody do
  context "when 'X-Cascade: pass'" do
    context "when 404 not found" do
      let(:app) { Rack::TruncateErrorBody.new(RackApp.new(404, true)) }

      it "removes body" do
        get "/"
        last_response.body.should be_empty
      end
    end

    context "when 200 OK" do
      let(:app) { Rack::TruncateErrorBody.new(RackApp.new(200, true)) }

      it "doesn't remove body" do
        get "/"
        last_response.body.should_not be_empty
      end
    end
  end

  context "without X-Cascade header" do
    context "when 404 not found" do
      let(:app) { Rack::TruncateErrorBody.new(RackApp.new(404, false)) }

      it "removes body" do
        get "/"
        last_response.body.should be_empty
      end

      context "with :only_cascaded option" do
        let(:app) { Rack::TruncateErrorBody.new(RackApp.new(404, false), only_cascaded: true) }

        it "doesn't remove body" do
          get "/"
          last_response.body.should_not be_empty
        end
      end
    end
  end

  describe "can set content_type in option" do
    context "without option" do
      let(:app) { Rack::TruncateErrorBody.new(RackApp.new(404, true)) }

      it "content type is text/plain" do
        get "/"
        last_response.content_type.should == "text/plain"
      end
    end

    context "with content_type option" do
      let(:app) { Rack::TruncateErrorBody.new(RackApp.new(404, true), content_type: 'application/x-msgpack') }

      it "content type is text/plain" do
        get "/"
        last_response.content_type.should == "application/x-msgpack"
      end
    end

  end
end
