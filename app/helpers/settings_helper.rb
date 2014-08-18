module SettingsHelper
	# Returns Current Users Chama Message Manager
   def correct_chama_setting(current_user)
    current_user.chama.setting
   end
end
