require "erb"

class BetweenPagesApp

  def call(env)
    @request = Rack::Request.new(env)
    case @request.path
    when "/"
        Rack::Response.new(render("homepage.html.erb"))
    when "/signin"
      Rack::Response.new(render("signinpage.html.erb"))
    when "/newuser"
      Rack::Response.new do |response|
        user = @request.params["username"]
        if user.nil? || user == ""
        elsif user == @request.cookies["user"]
          response.set_cookie("welcome_message", "Welcome back " + user)
        else
          response.set_cookie("welcome_message", "Welcome for the first time " + user)
          response.set_cookie("user", user)
        end
        response.redirect("/")
      end
    else
      Rack::Response.new(render("homepage.html.erb"))
    end
  end

  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end

  def welcome_message
    @request.cookies["welcome_message"]
  end

end
