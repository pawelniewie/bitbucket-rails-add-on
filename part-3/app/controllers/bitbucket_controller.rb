class BitbucketController < ApplicationController

	def descriptor
		render :descriptor, locals: { 
			base_url: ApplicationController.renderer.defaults[:http_host]
		}
	end

end
