module PostsHelper

  def wrap(content)
    sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end

  def embed(url)
      url = @post.embed_url.split('src="').last
      url2 = url.split('"').first 
      new_url = url2 + "&wmode=opaque"
      content_tag(:iframe, nil, frameborder: 0, scrolling: 'no', src: new_url)
  end

  private

    def wrap_long_string(text, max_width = 30)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
                                  text.scan(regex).join(zero_width_space)
    end
end

