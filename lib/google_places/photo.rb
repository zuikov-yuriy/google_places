module GooglePlaces
  class Photo
    attr_accessor :width, :height, :photo_reference, :html_attributions

    def initialize(width, height, photo_reference, html_attributions, api_key, sensor)
      @width             = width
      @height            = height
      @photo_reference   = photo_reference
      @html_attributions = html_attributions
      @api_key           = api_key
      @sensor            = sensor
    end

    # Search for a Photo's url with its reference key
    #
    # @return [URL]
    # @param [String] api_key the provided api key
    # @param [Boolean] sensor
    #   Indicates whether or not the Place request came from a device using a location sensor (e.g. a GPS)
    #   to determine the location sent in this request.
    #   <b>Note that this is a mandatory parameter</b>
    # @param [Hash] options
    # @option options [Hash] :retry_options ({})
    #   A Hash containing parameters for search retries
    # @option options [Object] :retry_options[:status] ([])
    # @option options [Integer] :retry_options[:max] (0) the maximum retries
    # @option options [Integer] :retry_options[:delay] (5) the delay between each retry in seconds
    def fetch_url(maxwidth, options = {})
      language  = options.delete(:language)
      retry_options = options.delete(:retry_options) || {}

      unless @fetched_url
        @fetched_url = Request.photo_url(
          :maxwidth => maxwidth,
          :photoreference => @photo_reference,
          :sensor => @sensor,
          :key => @api_key,
          :retry_options => retry_options
        )
      end
      @fetched_url
    end
  end
end
