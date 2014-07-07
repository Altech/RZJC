class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :logging_access

  def logging_access
    return if not Rails.env.production?
    logger = Fluent::Logger::FluentLogger.new(nil, :host => 'vs-seed.net:8888')
    logger.post('production.rzjc.access',
                method: request.method,
                path: request.fullpath,
                referer: request.referer,
                agent: request.user_agent,
                ip: request.ip)
  end
end
