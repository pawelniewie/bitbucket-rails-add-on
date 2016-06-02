class BitbucketController < ApplicationController

	def descriptor
		render :descriptor, locals: { 
			base_url: 'https://' + ApplicationController.renderer.defaults[:http_host],
			plugin_key: PluginKeyService::PLUGIN_KEY
		}
	end

end
