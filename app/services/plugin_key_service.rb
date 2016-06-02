module PluginKeyService

	PLUGIN_KEY = 'stars' + ("." + Rails.env unless Rails.env.production?)

end