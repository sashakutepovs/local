userDir = System_Settings::USER_DATA_PATH

# Check if the directory exists
unless Dir.exist?(userDir)
	# Create the directory if it doesn't exist
	Dir.mkdir(userDir)
	puts "Directory created: #{userDir}"
else
	puts "Directory already exists: #{userDir}"
end

if !File.exists?(userDir + "GameLona.ini")
			p "GameLona.ini not exists. self create ini"
			new_file = IniFile.new
			# set properties
			new_file["LonaRPG"]={}
			# pretty print object
			p new_file
			# set file path
			new_file.filename = userDir+"GameLona.ini"
			# save file
			new_file.write()
			sleep 1
end

#by 417 added in 0730
tgtDir = "ModScripts/"
unless Dir.exist?(tgtDir)
	Dir.mkdir(tgtDir)
	puts "Directory created: #{tgtDir}"
else
	puts "Directory already exists: #{tgtDir}"
end

tgtDir = "ModScripts/_Mods/"
unless Dir.exist?(tgtDir)
	Dir.mkdir(tgtDir)
	puts "Directory created: #{tgtDir}"
else
	puts "Directory already exists: #{tgtDir}"
end


if !File.exists?(userDir + "GameMods.ini")
	new_file = IniFile.new
	# set properties
	new_file["Mods"]={}
	# pretty print object
	p new_file
	# set file path
	new_file.filename = userDir + "GameMods.ini"
	# save file
	new_file.write()
end


sleep 0.1
$LonaINI = IniFile.load(userDir + "GameLona.ini")
$GameINI = IniFile.load("Game.ini")
sleep 0.9
