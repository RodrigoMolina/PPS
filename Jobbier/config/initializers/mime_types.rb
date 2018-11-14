# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
module Mime
  class Type
    class << self
      def lookup_by_extension(extension)
        mime_type = EXTENSION_LOOKUP[extension.to_s]
        if mime_type.nil?
          mime_type = Mime::HTML
        end
        mime_type
      end
    end
  end
end
