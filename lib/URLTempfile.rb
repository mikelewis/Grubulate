require 'iconv'
require 'openssl'
require 'net/http'

class RedirectFollower
  class TooManyRedirects < StandardError; end

  attr_accessor :url, :body, :redirect_limit, :response

  def initialize(url, limit=5)
    @url, @redirect_limit = url, limit
  end

  def resolve
    raise TooManyRedirects if redirect_limit < 0

    self.response = Net::HTTP.get_response(URI.parse(url))

    if response.kind_of?(Net::HTTPRedirection)      
      self.url = redirect_url
      self.redirect_limit -= 1

      resolve
    end

    self.body = response.body
    self
  end

  def redirect_url
    if response['location'].nil?
      response.body.match(/<a href=\"([^>]+)\">/i)[1]
    else
      response['location']
    end
  end
end


# This class provides a Paperclip plugin compliant interface for an "upload" file
# where that uploaded file is actually coming from a URL.  This class will download
# the file from the URL and then respond to the necessary methods for the interface,
# as required by Paperclip so that the file can be processed and managed by 
# Paperclip just as a regular uploaded file would.
#
class URLTempfile < Tempfile
  attr :content_type

  def initialize(url)
    file = RedirectFollower.new(url).resolve
    @url = file.url

    # see if we can get a filename
    raise "Unable to determine filename for URL uploaded file." unless original_filename

    begin
      # HACK to get around inability to set VERIFY_NONE with open-uri
      old_verify_peer_value = OpenSSL::SSL::VERIFY_PEER
      openssl_verify_peer = OpenSSL::SSL::VERIFY_NONE

      super('urlupload')
      @content_type = file.response['content-type']
      raise "Unable to determine MIME type for URL uploaded file." unless content_type

      if file.body.respond_to?(:force_encoding)
        f_contents = file.body.force_encoding("UTF-8")
      else
        f_contents = file.body
      end
      self.write f_contents
      self.flush
    ensure
      openssl_verify_peer = old_verify_peer_value
    end
  end

  def original_filename
    # Take the URI path and strip off everything after last slash, assume this
    # to be filename (URI path already removes any query string)
    match = @url.match(/^.*\/(.+)$/)
    return (match ? match[1] : nil)
  end

  protected

  def openssl_verify_peer=(value)
    silence_warnings do
      OpenSSL::SSL.const_set("VERIFY_PEER", value)
    end
  end
end
