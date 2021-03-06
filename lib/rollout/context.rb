module Rollout
  class Context
    attr_reader :controller, :logger, :selections, :digester

    def initialize(controller = nil, options = {})
      @controller = controller
      @digester = Digest::SHA256.new
      @logger = options[:logger] || Rails.logger
      @selections = []
    end

    def features
      raise 'Not implemented'
    end

    def uaid
      raise 'Not implemented'
    end

    def user_id
      raise 'Not implemented'
    end

    def user_name
      raise 'Not implemented'
    end

    def admin?
      raise 'Not implemented'
    end

    def in_group?(user_id, groups)
      raise 'Not implemented'
    end

    def internal_request
      raise 'Not implemented'
    end

    # Produce a random number in [0, 1] for RANDOM bucketing.
    def random
      rand
    end

    def log(name, variant, selector)
      selections << [name, variant, selector]
      logger.info(name, variant, selector)
    end

    def hash(id)
      # TODO: benchmark each, allow user to pick?
      # map_hex(digester.hexdigest(digester.digest(id.to_s)))
      (Zlib.crc32(id.to_s) % 100) * 0.01
    end


    def map_hex(hex)
      len = [40, hex.length].min
      max = 1 << len
      v = 0
      (0...len).each do |i|
        bit = hex[i].hex < 8 ? 0 : 1
        v = (v << 1) + bit
      end
      v.to_f / max
    end

  end

end
