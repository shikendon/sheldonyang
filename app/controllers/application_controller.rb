class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :load_config

  def load_config
    @site_name = 'Gong Guan Elementary School - learning English'
  end

  def get_response(url)
    http = Net::HTTP.new(url.host, url.port)
    http.open_timeout = 5
    http.read_timeout = 5
    pathname = url.query.nil? ? url.path : "#{url.path}?#{url.query}"
    res = http.start {|http| http.get(pathname)}
  end

  def post_form(url, params)
    http = Net::HTTP.new(url.host, url.port)
    http.open_timeout = 5
    http.read_timeout = 5
    pathname = url.query.nil? ? url.path : "#{url.path}?#{url.query}"
    res = http.post(pathname, URI.encode_www_form(params))
  end
end
