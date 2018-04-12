class FileParser
  require 'json'

  def initialize(file_path)
    @file_path = file_path
  end

  def perform
    parse_file
  end

  ERROR_MESSAGES = {
    not_found: 'Cannot find file',
    wrong_format: 'This file format is not supported'
  }.freeze

  private

  def parse_file
    file = read_file
    return ERROR_MESSAGES[:not_found] + " '#{@file_path}' :-(" unless file
    JSON.parse(file)
  rescue JSON::ParserError
    ERROR_MESSAGES[:wrong_format]
  end

  def read_file
    File.read(@file_path)
  rescue Errno::ENOENT
  end
end
