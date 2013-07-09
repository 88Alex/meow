require "requires"
require "toml"
require "etc/logger"
require "archive-zip"
require "net/http"
require "uri"

package = ARGV.shift
if not File.exist? "C:\\Program Files\\Meow\\meowfiles\\{package}.meow"
	error "Package {package} not found. Run meow install {package}."
	exit 1
end
meow = TOML.parsefile("C:\\Program Files\\Meow\\meowfiles\\{package}.meow")
if meow["type"] = "library"
	domain = URI.parse(meow["download"]).host
	Net::HTTP.start(domain) do |http|
		file = meow["download"]
		tmp_len = domain.len + 7
		file.slice!(file[0..tmp_len])
		resp = http.get(file)
		if resp.code == 200
			lfile = "C:\\Program Files\\Meow\\temp\\{package}.zip"
			File.open(lfile, "w") do |f|
				f.write(resp.body)
			end
			log "Successful download"
		else
			error "Download failed."
			exit 1
		end
	end
	Archive::Zip.extract("zipfile", "C:\Program Files\\Meow\\libraries\\")
	File.open("C:\\Program Files\\Meow\\libraries") do |f|
		version = meow["version"]
		language = meow["language"]
		f.write("{package} : {version} : {language}")
	end
	log "Successfully installed package {package}"
elsif meow["type"] = "exe"
	warn "This program installs to its own Program Files directory,"
	warn "as opposed to Meow's directory. Do you want to proceed (y/n)?"
	char = getc
	exit(2) if char != 'y' and char != 'Y'
	domain = URI.parse(meow["download"]).host
	Net::HTTP.start(domain) do |http|
		file = meow["download"]
		tmp_len = domain.len + 7
		file.slice!(file[0..tmp_len])
		resp = http.get(file)
		if resp.code == 200
			lfile = "C:\\Program Files\\Meow\\temp\\{package}_installer.exe"
			File.open(lfile, "wb") do |f|
				f.write(resp.body)
			end
			log "Successful download"
		else
			error "Download failed."
			exit 1
		end
	end
	system("C:\\Program Files\\Meow\\temp\\{package}_installer.exe")
	log "Installation complete."
elsif meow["type"] = "source"
	# It's a source code program
else
	error "Invalid .meow file"
	exit 1
end
