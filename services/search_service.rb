class SearchService
  require 'time'

  def initialize(data, target)
    @data = data
    @target = target.downcase
  end

  def perform
    error = 'No results found'
    return error if @target.empty?
    result = format_result
    result.any? ? result : error
  end

  private

  def format_result
    @data.each_with_object([]) do |object, memo|
      next unless phase_found?(object)
      memo << format_object(object)
    end
  end

  def phase_found?(object)
    case object
    when Enumerable
      object.any? { |obj| phase_found?(obj) }
    else
      object.to_s.downcase.match(@target)
    end
  end

  def format_object(object)
    object.map { |k, v| format_hash(k, v) }.join("\n") + "\n" + '-' * 100 + "\n"
  end

  def format_hash(key, value)
    key = key.to_s.gsub('_', ' ').strip.capitalize
    value = format_value(value)
    "#{key}: #{value}"
  end

  def format_value(value)
    case value
    when Array
      value.join(', ')
    when Hash
      value.map { |k, v| "#{k}: #{v}"}.join(',')
    when /(\d{4})-(\d{2})-(\d{2})T(\d{2})\:(\d{2})\:(\d{2})\s+[+-](\d{2})\:(\d{2})/
      Time.parse(value).strftime('%d/%m/%Y %H:%M %:z')
    else
      value
    end
  end
end
