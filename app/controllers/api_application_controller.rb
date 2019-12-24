class ApiApplicationController < ActionController::Base
  include ApiApplicationHelper
  before_action :require_login
end
