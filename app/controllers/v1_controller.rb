class V1Controller < ApplicationController
  def index
    render json: "{testing: hihi}"
  end
end
