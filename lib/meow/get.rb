require "etc/logger"
require "requires"
require "net/http"

def get(name)
	Net::HTTP.start("github.com") do |http|
		rfile = "/88Alex/meowfiles/{name}.meow"
		resp = http.get(rfile)
		if resp.code == 200
			lfile = "C:\\Program Files\\Meow\\meowfiles\\" \
			+ "{name}.meow"
			File.open(lfile, "w") do |f|
				f.write(resp.body)
			end
			log "Successfully downloaded package {name}"
		else
			error "No such package {name}"
		end
	end
end

# parse command options here

package = ARGV.shift
get(package)

