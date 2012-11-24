module Jekyll
	class Post
		attr_accessor :page_language

		alias super_url url
		def url
			_url = super_url
			default_language = self.site.config['default_language'] || 'en'
			@page_language = @page_language || self.slug[/\.([^\/.]*)$/, 1] || default_language
			if @page_language != default_language
				url_prefix = "/#{@page_language}"
			end
			_url = "#{url_prefix}#{_url}".gsub(".#{@page_language}", "")
			self.slug = self.slug.gsub(".#{@page_language}", "")
			self.data['language'] = @page_language
			self.data.deep_merge({ 'page_language' => @page_language });
			return _url
		end
	end
end

