module Jekyll
    class ViemoTag < Liquid::Tag
    
        def initialize(tag_name, video_numner, tokens)
            super
            @video_numner = video_numner
            #@video_description = video_description
        end
        
        def render(content)
            "<iframe src=\"https://player.vimeo.com/video/#{@video_numner}\" width=\"500\" height=\"281\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>"
        end
    end
end

Liquid::Template.register_tag('viemo', Jekyll::ViemoTag)