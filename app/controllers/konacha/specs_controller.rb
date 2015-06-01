module Konacha
  class SpecsController < ActionController::Base
    rescue_from Konacha::Spec::NotFound do
      render :text => "Not found", :status => 404
    end

    def parent
      @run_mode = params.fetch(:mode, Konacha.mode).to_s.inquiry
      @specs = Konacha::Spec.all(params[:path])
      @stylesheets = Konacha::Engine.config.konacha.stylesheets
      @javascripts = Konacha::Engine.config.konacha.javascripts
    end
  end
end
