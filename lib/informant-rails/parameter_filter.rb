module InformantRails
  class ParameterFilter
    def self.filter(name, value)
      Config.value_tracking && !matcher.match(name) ? value : '[FILTERED]'
    end

    protected

    def self.matcher
      @matcher ||= Regexp.new(/#{Config.filter_parameters.join('|').presence || '$^'}/)
    end
  end
end
