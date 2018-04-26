require "./ambatch/*"
require "option_parser"
require "yaml"

# Ambatch processes a yml file, turns each item into a String and passes the
# results to the command line. Useful for projects where you want to mock up
# a structure without commiting to use the generators ahead of time.
module Ambatch

  # Ambatch::Parser utilizes a series of class methods to parse an YAML file
  # to an array of stringified text and executes each, making a system call
  class Parser

    def self.parse_yaml(path : String)
      begin
        raise Exception.new ("Error: File not found.") if !File.file? path
        raise Exception.new ("Error: File extension is not .yml") if File.extname(path) != ".yml"
        YAML.parse(File.read path)
      rescue ex
        puts ex.message
      end


    end

    def self.stringify(yaml)
      commands = [] of String
      if yaml
        yaml.each do |key, value|
          value.each do |k, v|
            result = ""
            result += key.to_s.downcase + " " + k.to_s + " " + v.to_a.join(" ")
            commands.push(result)
          end
        end
        commands
      end
    end

    def self.run
      OptionParser.parse! do |parser|
        parser.banner = "Usage: ambatch -f /path/to/file.yml"
        parser.on "-f PATH", "--file PATH", "Path to a file" do |path|

          begin
            commands = self.stringify(self.parse_yaml(path))
            commands.each do |line|
              puts system "amber g " + line
            end if commands
          rescue ex
            raise "#{ex}"
          end
        end
        parser.on "-h", "--help", "Show this help" do
          puts parser
          exit 0
        end
        parser.on "-v", "--version", VERSION do
          puts VERSION
          exit 0
        end
      end
    end
  end
end

Ambatch::Parser.run
