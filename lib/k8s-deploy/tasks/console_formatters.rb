# frozen_string_literal: true

DELIMITER_WIDTH = 80

CONSOLE_COLORS = {
  red: "\x1b[31;01m",
  yellow: "\x1b[33;01m",
  green: "\x1b[32;01m",
  no_color: "\x1b[0m"
}.freeze

# colorizing output
def color_output(color)
  raise 'Wrong color name' unless CONSOLE_COLORS.key?(color)

  CONSOLE_COLORS[color] + yield.to_s + CONSOLE_COLORS[:no_color]
end

def command_output(text)
  puts "#> #{text}"
end

def block_output(header)
  prepared_header = color_output(:yellow) { " #{header} " }

  # adding 12 to fix size of non-visible color symbols
  puts
  puts prepared_header.center(DELIMITER_WIDTH + 12, '=')

  puts
  yield
  puts
end

def check_result_output(result)
  if result
    color_output(:green) { 'Ok' }
  else
    color_output(:red) { 'Fail' }
  end
end
