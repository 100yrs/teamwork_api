# frozen_string_literal: true

module TeamworkApi
  # Make it easier to deal with params
  module API
    def self.params(args)
      Params.new(args)
    end

    # The useful stuff is here
    class Params
      def initialize(args)
        raise(ArgumentError, 'Required to be initialized with a Hash') unless
          args.is_a? Hash

        @args = args
        @required = []
        @optional = []
        @defaults = {}
      end

      def required(*keys)
        @required.concat(keys)
        self
      end

      def optional(*keys)
        @optional.concat(keys)
        self
      end

      def default(args)
        args.each do |k, v|
          @defaults[k] = v
        end
        self
      end

      def to_h
        h = {}

        @required.each do |k|
          h[k] = @args[k]
          raise(ArgumentError, "#{k} is required but not specified") unless h[k]
        end

        @optional.each do |k|
          h[k] = @args[k] if @args.include?(k)
        end

        @defaults.each do |k, v|
          h[k] = (@args.key?(k) ? @args[k] : v)
        end

        caseify_keys(h)
      end

      def caseify_keys(hash)
        caseified_hash = {}
        hash.each do |k, v|
          key = (k.match?(/-/) ? k.to_s : camelize(k.to_s))
          caseified_hash[key] = v
        end

        caseified_hash
      end

      def camelize(string)
        string = string.sub(/^(?:(?=\b|[A-Z_])|\w)/) { $&.downcase }
        string.gsub(%r{(?:_|(\/))([a-z\d]*)}) {
          "#{Regexp.last_match(1)}#{Regexp.last_match(2).capitalize}"
        }.gsub('/', '::')
      end
    end
  end
end
