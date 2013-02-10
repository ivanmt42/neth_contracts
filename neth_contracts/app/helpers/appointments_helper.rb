module AppointmentsHelper

	def display_referred_by(appointment)
		referral = appointment.referral.to_s
		referral_option = appointment.referral_option.to_s
		if referral == "Referred by"
			referred_by = referral + ": " + referral_option
		else
			referred_by = referral
		end
		return referred_by
	end
end
