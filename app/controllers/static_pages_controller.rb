class StaticPagesController < ApplicationController
	before_action :signed_in_user, only: [:home]
	def home
	end
end
