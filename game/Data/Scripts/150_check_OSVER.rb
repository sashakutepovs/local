
module DataManager
	#old, can only trans without HEX
	#def self.get_game_ver(gameVer=$GameINI["Game"]["Title"])
	#	return 0 if !gameVer
	#	return 0 if !gameVer.is_a?(String)
	#	numeric_part = gameVer.split('.').drop(1)
	#	version_string = numeric_part.join
	#	result = version_string.to_f / 10**(numeric_part.length - 1)
	#	return result
	#end

	#GPT ver
	def self.translate_game_ver(gameVer)
		return 0 if !gameVer || !gameVer.is_a?(String)

		# Split the string and remove leading non-numeric parts (e.g., "B.")
		numeric_part = gameVer.split('.').drop(1)

		# Filter out any segments that contain English letters
		filtered_numeric_parts = numeric_part.reject { |part| part.match(/[a-zA-Z]/) }

		# Convert segments to their proper place values
		result = 0.0
		filtered_numeric_parts.each_with_index do |part, index|
			result += part.to_i / (10.0**index)
		end

		# Round to the desired number of decimal places
		result.round(filtered_numeric_parts.size)
	end
	#def self.translate_game_ver(gameVer)
	#	return 0 if !gameVer || !gameVer.is_a?(String)
	#	# Split the string and remove any leading non-numeric parts (e.g., "B.")
	#	numeric_part = gameVer.split('.').drop(1)
	#	# Filter out any segments that contain English letters
	#	filtered_numeric_parts = numeric_part.reject { |part| part.match?(/[a-zA-Z]/) }
	#	# Join the remaining numeric parts to form the version string
	#	main_version = filtered_numeric_parts.join
	#	result = main_version.to_f / 10**(filtered_numeric_parts.length - 1)
	#	return result
	#end

	def self.get_os_id
		if Dir.exist?("/etc/")
			# Check if deckOS
			if File.exist?('/etc/os-release')
				is_steamrt = false
				is_steamdeck = false

				File.foreach('/etc/os-release') do |line|
					is_steamrt = true if line.start_with?("ID=steamrt")
					is_steamdeck = true if line.start_with?("ID_LIKE=") && line.include?("steamos")
				end

				return "Steam Deck" if is_steamdeck
				return "Steam Runtime" if is_steamrt
			end
			"Linux"
		elsif RUBY_PLATFORM =~ /linux/
				# Read ID from /etc/os-release if available (Linux)
			if File.exist?('/etc/os-release')
				File.foreach('/etc/os-release') do |line|
					return line.split('=').last.strip if line.start_with?("ID=")
				end
			end
			"Linux"
		elsif RUBY_PLATFORM =~ /darwin/
			"macOS"
		elsif RUBY_PLATFORM =~ /win32|win64|\.NET|windows/i
			"Windows"
		else
			"Unknown"
		end
	end
end
#msgbox os_id
