module Rsodx::Constants
  ASCII_LOGO = <<~ASCII.freeze
    \e[36m   _____     _____     ____    _____    __   __ 
      |  __ \\   / ____|   / __ \\  |  __ \\   \\ \\ / / 
      | |__) | | (___    | |  | | | |  | |   \\ V /  
      |  _  /   \\___ \\   | |  | | | |  | |    \e[35m> <\e[0m\e[36m
      | | \\ \\   ____) |  | |__| | | |__| |   / \e[35m.\e[0m\e[36m \\  
      |_|  \\_\\ |_____/    \\____/  |_____/   /_/ \\_\\  \e[33mv__VERSION__\e[0m
  ASCII

  LOGO = ASCII_LOGO.sub("__VERSION__", Rsodx::VERSION).freeze
end

module Rsodx
  include Rsodx::Constants
end
