require "between_pages_app"

use Rack::Reloader, 0

run BetweenPagesApp.new
