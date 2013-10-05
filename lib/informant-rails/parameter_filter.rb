module InformantRails
  class ParameterFilter
    def self.filter(name, value)
      value && matcher.match(name) ? '[FILTERED]' : value
    end

    protected

    def self.matcher
      @matcher ||= Regexp.new(/#{InformantRails::Config.filter_parameters.join('|').presence || '$^'}/)
    end
  end
end
