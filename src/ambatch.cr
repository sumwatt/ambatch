require "./ambatch/*"
require "option_parser"
require "yaml"

# Ambatch processes a yml file, turns each item into a String and passes the
# results to the command line. Useful for projects where you want to mock up
# a structure without commiting to use the generators ahead of time.
module Ambatch

  class Parser

    def self.run
      OptionParser.parse! do |parser|
        parser.banner = "Usage: ambatch -f /path/to/file.yml"
        parser.on "-f PATH", "--file PATH", "Path to a file" do | path |
          # TODO clean this parsing up
          begin
            data = YAML.parse(File.read path)
            lines = [] of String
            if data
              data.each do |key, value|
                value.each do |k, v|
                  result = ""
                  result += key.to_s.downcase + " " + k.to_s + " " + v.to_a.join(" ")
                  lines.push(result)
                end
              end

              lines.each do |line|
                puts system "amber g " + line
              end
            end

          # TODO it would be helpful to know the types of erros this creates...
          rescue YAML::ParseException
            raise "Could not parse file"
          rescue ex
            raise "Some other error occurred"
          end
        end
        parser.on "-h", "--help", "Show this help" do
          puts parser
          exit 0
        end
        parser.on "-v", "--version", "0.1.0" do
          puts parser
          exit 0
        end
      end
    end
  end
end

Ambatch::Parser.run
