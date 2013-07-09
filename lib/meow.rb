require "rubygems"
require "bundler/setup"
require "toml"
require "meow/requires"

verbose = false
while 1 == 1
	arg = ARGV.shift
	if arg.startswith("--")
		# parse it as a global option
		verbose = true if arg <=> "--verbose"
		verbose = false if arg <=> "--noverbose"
		if arg <=> "--help"
			# print help message
		end
		# other options here
	elsif arg.startswith("-")
		verbose = true if arg.include 'v'
		verbose = false if arg.include 'V'
		# other options here
	else
		break
	end
end

# Now we've parsed all the global options

command = ARGV.shift

if File.exist? "meow/{command}.rb"
	`meow\{command}.rb {ARGV.join(' ')}`
else
	output_error "No such command. Run meow --help for a list of commands."
end
