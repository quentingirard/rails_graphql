class Api::V1::ApplicationController < ApplicationController
  before_action :authenticate_api_v1_user!

  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  skip_forgery_protection
end
