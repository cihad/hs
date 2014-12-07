module Administration
  class BaseController < ApplicationController
    layout "control"

    before_filter :authorize_dasboard

    def index
    end

  private

    def authorize_dasboard
      authorize :dashboard, :show?
    end

  end
end