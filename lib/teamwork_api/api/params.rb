# frozen_string_literal: true

module TeamworkApi
  module API
    def self.params(args)
      Params.new(args)
    end

    class Params
      def initialize(args)
        raise ArgumentError.new('Required to be initialized with a Hash') unless
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
          raise ArgumentError.new("#{k} is required but not specified") unless
            h[k]
        end

        @optional.each do |k|
          h[k] = @args[k] if @args.include?(k)
        end

        @defaults.each do |k, v|
          @args.key?(k) ? h[k] = @args[k] : h[k] = v
        end

        caseify_keys(h)
      end

      def caseify_keys(h)
        caseified_hash = {}
        h.each do |k, v|
          if k =~ /-/
            key = k.to_s
          else
            key = k.to_s.camelize(:lower)
          end
          caseified_hash[key] = v
        end

        caseified_hash
      end
    end
  end
end
