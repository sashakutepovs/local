#==============================================================================
# ** Mail System **
#
# Author:     Evgenij
# Date:       30.09.2014
# Version:    1.1b
# ToF:        evgenij-scripts.org
#
# Thanks to: MHRob for requesting this script
#==============================================================================
#
# Changelog:
# 30.09.2014 - V. 1.1b:
#   - bugfix
#   - new format for SENDER Configuration
#
# 28.09.2014 - V. 1.1a:
#   - bugfixes
#
# 25.09.2014 - V. 1.1:
#   - bugfixes
#   - added gold to attachments
#   - new feature: custom windowskin
#   - new feature: run common_event when reading mail
#   - new scriptcall: $game_system.attachments_claimed?(:symbol)
#
# 24.09.2014 - V. 1.0:
#   - script created
#
#==============================================================================
#
# Description:
#
#   This script adds an email scene to your game, you need to predefine senders
#   and emails in the script and after that you can send them to the player via
#   a script call.
#
# Script Calls:
#
# SceneManager.call(Scene_Mail)  # to call the scene
#  
# $game_system.add_email(:symbol)
# $game_system.remove_email(:symbol)
# $game_system.has_email?(:symbol)            # checks if player has email
# $game_system.attachments_claimed?(:symbol)  # checks if the attachments were
#                                             # claimed
#
#==============================================================================
module EVG
	module MAIL
		#--------------------------------------------------------------------------
		# Some Escape Codes which can be used almost everywhere:
		# \n           => new line
		# \\c[index]   => change color (windowskin index)
		# \\b          => toogle bold on or off
		# \\i[index]   => show icon
		#--------------------------------------------------------------------------

		#--------------------------------------------------------------------------
		# Cosmetic and Vocab Config:
		#--------------------------------------------------------------------------
		#ALL_VOCAB = "ALL"
		#UNREAD_VOCAB = "Unread"
		#READ_VOCAB = "Read"
		#DELETED_VOCAB = "Deleted"

		#ACTION_READ_VOCAB = "Read"
		#ACTION_MARK_READ_VOCAB = "Mark read"
		#ACTION_MARK_UNREAD_VOCAB = "Mark unread"
		#ACTION_DELETE_VOCAB = "Delete"
		#ACTION_GET_ATTACHMENTS_VOCAB = "Get Attach."
		# %s and %s get replaced by the sender name and the sender address
		#HEADER_FROM_VOCAB = "\\b\\c[5]FROM\\c[0]: \\c[6]%s "
		# %s gets replaced by the mail name
		#HEADER_SUBJECT_VOCAB = "\\b\\c[5]SUBJECT\\c[0]: \\c[6]%s\\b"
		#ATTACHMENTS_VOCAB = "\\b\\c[13]Attachments\\c[0]\\b"
		#CLAIMED_VOCAB = "Claimed"

		# Use windowskin colors only
		#CLAIMED_COLOR = 25
		#SENDER_COLOR = 2

		#ATTACHMENT_ICON = 258
		#READ_ICON = 236
		#UNREAD_ICON = 235
		#NEW_MAIL_ICON = 235
		#GOLD_ICON = 361

		# You can use custom windowskin, put the file in Graphics/System
		# if the file dont exist, the window skin wont change, you also get no
		# error.
		#WINDOWSKIN = "mailwindow"
		#WINDOWTONE = Tone.new(0, 0, 0, 0)

		#--------------------------------------------------------------------------
		# Settings:
		#--------------------------------------------------------------------------
		#GET_ATTACHMENTS_WHEN_MARKREAD = true
		#GET_ATTACHMENTS_WHEN_DELETE = true
		#SHOW_DELETED_CATEGORY = true
		# If this switch will be on, no notification will be shown when the player
		# is on map and have unread emails
		#NOTIFICATION_ON_MAP_OFF_SWITCH = 999

		#ADD_EMAIL_COMMMAND_TO_MENU = true
		#COMMAND_VOCAB = "View Mails"
		#COMMAND_SWITCH = 999  # For enabling or disabling the command in menu

		#--------------------------------------------------------------------------
		# Configure possible senders:
		#--------------------------------------------------------------------------
		#SENDERS = { # Do not edit this line
		##--------------------------------------------------------------------------
		#  :eric => {:name => "Eric", :address => "eric@rpgmaker.rm"},
		#  :natalie => {:name => "Natalie", :address => "natalie@rpgmaker.rm"},
		#  :me => {:name => "Me, the king", :address => "me@rpgmaker.rm"},
		#--------------------------------------------------------------------------
		#} # Do not edit this line
		#--------------------------------------------------------------------------
		#EMAILS = { # do not edit this line
		#--------------------------------------------------------------------------
		# Configure e-mails
		# Template:
		#
		# :symbol => {  # the symbol has to be unique
		#
		#   :sender => :eric,  # take a sender from above SENDERS
		#
		#   :name   => "Email Name",
		#
		#   :text   => "Email Text",   # You can use escape codes
		#
		#   :attachments => [w1, i12, a13], # would give the player weapon 1, item 12
		#                                   # and armor 13 as attachment.
		#                                   # attachments are optional
		#
		#   # Optional you can run common events when the player claims an attachment
		#   # or reads the mail:
		#
		#   :attach_ce => id,               # only works when attachments are used
		#                                   # starts the common event with id when
		#                                   # attachments are claimed, also optional
		#   :read_ce => id,                 # starts common event with id when email
		#                                     gets read
		# },
		#--------------------------------------------------------------------------

		#--------------------------------------------------------------------------
		#} # Do not edit this line
		#--------------------------------------------------------------------------
		#============================================================================
		# CONFIG END
		#============================================================================
		def initialize(*args)
			super(*args)
			#skin = Cache.system(WINDOWSKIN) rescue nil
			#self.windowskin = skin if skin
		end
		#def update_tone
		#  self.tone.set(WINDOWTONE)
		#end
	end # module MAIL
	#============================================================================
	#	Added By Kslander to furthure reduce save file size, Used to
	#	Save read / unread / deleted status of all mails
	#============================================================================
	class EMailReader
		#--------------------------------------------------------------------------
		attr_reader :symbol
		attr_reader :common_event_attach
		attr_reader :common_event_read
		attr_reader :date

		#--------------------------------------------------------------------------
		def initialize(symbol)
			@symbol = symbol
			@date = Time.now
			@state = :unread
		end

		def export_textString(type)
			textString = File.read($mail_text.filenameList[@symbol])
			$mail_text.decode_text(textString ,@symbol+ "/" + type)
		end
		def name
			export_textString("Title")
		end

		def sender
			export_textString("Sender")
		end
		def text
			return $story_stats["logTxt"] if @symbol == "TextLog1"
			return $story_stats["logNarr"] if @symbol == "TextLog2"
			return $story_stats["logBoard"] if @symbol == "TextLog3"
			export_textString("Text")
		end

		#--------------------------------------------------------------------------
		def all?
			!deleted?
		end
		#--------------------------------------------------------------------------
		def read
			@state = :read
			$game_system.calc_unread_mail_count
			#@read_ce = true
		end
		#--------------------------------------------------------------------------
		def read?
			@state == :read
		end
		#--------------------------------------------------------------------------
		def unread
			@state = :unread
			$game_system.calc_unread_mail_count
		end
		#--------------------------------------------------------------------------
		def unread?
			@state != :read
		end
		#--------------------------------------------------------------------------
		def delete
			@deleted = true
			$game_system.calc_unread_mail_count
		end
		#--------------------------------------------------------------------------
		def undelete
			@deleted = false
			$game_system.calc_unread_mail_count
		end
		#--------------------------------------------------------------------------
		def deleted?
			@deleted
		end
		#--------------------------------------------------------------------------
		def attachments?
			@attachments && !@attachments.empty?
		end
		#--------------------------------------------------------------------------
		def claim_attachments
			return if @attachments_claimed
			@attachments_claimed = true
		end
		#--------------------------------------------------------------------------
		def attachments_claimed?
			@attachments_claimed || !attachments?
		end
		#--------------------------------------------------------------------------
		def attach_common_event?
			!@common_event_attach.nil? && @common_event_attach != 0
		end
		#--------------------------------------------------------------------------
		def read_common_event?
			!@common_event_read.nil? && @common_event_read != 0
		end
		#--------------------------------------------------------------------------
		def read_common_event_ran?
			return @read_ce
		end
	end #class EMailReader


	class EMail
		#--------------------------------------------------------------------------
		attr_reader :symbol
		attr_reader :name
		attr_reader :address
		attr_reader :title
		attr_reader :text
		attr_reader :sender
		attr_reader :date
		attr_reader :attachments
		attr_reader :common_event_attach
		attr_reader :common_event_read
		attr_writer :read_ce
		#--------------------------------------------------------------------------
		def initialize(symbol, properties)
			@symbol = symbol
			@sender =  properties[:sender_name]
			#@address = properties[:sender_address]
			@name = properties[:name]
			@text = properties[:text]
			@attachments = properties[:attachments]
			@title = properties[:title]
			@common_event_attach = properties[:attach_ce]
			@common_event_read   = properties[:read_ce]
			@read_ce = false
			@deleted = false
			@date = Time.now
			@state = :unread
		end


		#--------------------------------------------------------------------------
		def all?
			!deleted?
		end
		#--------------------------------------------------------------------------
		def read
			@state = :read
			$game_system.calc_unread_mail_count
			#@read_ce = true
		end
		#--------------------------------------------------------------------------
		def read?
			@state == :read
		end
		#--------------------------------------------------------------------------
		def unread
			@state = :unread
			$game_system.calc_unread_mail_count
		end
		#--------------------------------------------------------------------------
		def unread?
			@state != :read
		end
		#--------------------------------------------------------------------------
		def delete
			@deleted = true
			$game_system.calc_unread_mail_count
		end
		#--------------------------------------------------------------------------
		def undelete
			@deleted = false
			$game_system.calc_unread_mail_count
		end
		#--------------------------------------------------------------------------
		def deleted?
			@deleted
		end
		#--------------------------------------------------------------------------
		def attachments?
			@attachments && !@attachments.empty?
		end
		#--------------------------------------------------------------------------
		def claim_attachments
			return if @attachments_claimed
			@attachments_claimed = true
		end
		#--------------------------------------------------------------------------
		def attachments_claimed?
			@attachments_claimed || !attachments?
		end
		#--------------------------------------------------------------------------
		def attach_common_event?
			!@common_event_attach.nil? && @common_event_attach != 0
		end
		#--------------------------------------------------------------------------
		def read_common_event?
			!@common_event_read.nil? && @common_event_read != 0
		end
		#--------------------------------------------------------------------------
		def read_common_event_ran?
			return @read_ce
		end
	end


	#--------------------------------------------------------------------------
	module AttachmentManager
		def self.get_item(code)
			if /([a, w, i, g])(\d+)/i =~ code.to_s
				case $1.upcase
				when 'W'
					$data_weapons[$2.to_i]
				when 'A'
					$data_armors[$2.to_i]
				when 'I'
					$data_items[$2.to_i]
				when 'G'
					$2.to_i
				end
			end
		end
	end
	#--------------------------------------------------------------------------
end # module EVG
#==============================================================================
class Game_System
	#--------------------------------------------------------------------------
	attr_reader :mails
	attr_reader :unread_mails_count
	#--------------------------------------------------------------------------
	alias :evg_gs_initialze_mail    :initialize
	def initialize
	evg_gs_initialze_mail
	@mails = {}
	@unread_mails_count = 0
	end
	#--------------------------------------------------------------------------
	def add_mail(mail_name)
		@mails ||= {}
		return if @mails[mail_name]
		@mails[mail_name] = EVG::EMailReader.new(mail_name)
		@mails = Hash[@mails.sort_by{|sym, mail| mail.date}.reverse]
		calc_unread_mail_count
	end
	#--------------------------------------------------------------------------
	def remove_mail(symbol)
	@mails.delete(symbol)
	calc_unread_mail_count
	end
	#--------------------------------------------------------------------------
	def attachments_claimed?(symbol)
	@mails[symbol].attachments_claimed?
	end
	#--------------------------------------------------------------------------
	def has_email?(symbol)
	!!@mails[symbol]
	end
	#--------------------------------------------------------------------------
	def calc_unread_mail_count
	@unread_mails_count = @mails.select{|sym, mail| mail.unread?}.size
	end
	#--------------------------------------------------------------------------
	
	def read_mails
		@mails.values.compact.select{|mail| mail.read? && !mail.deleted?}
	end
	
	def unread_mails
		@mails.values.compact.select{|mail| mail.unread? && !mail.deleted?}
	end
	
	def deleted_mails
		@mails.values.compact.select(&:deleted?)
	end
	
	def all_mails
		@mails.values.compact.select(&:all?)
	end
	

end
