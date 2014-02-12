module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 })
  	userEmail = "text@text.com"
  	if !user.nil?
  		userEmail = user.email.downcase
  	end
    gravatar_id = Digest::MD5::hexdigest(userEmail)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    image_tag(gravatar_url, class: "gravatar")
  end
end