require "./ambatch/*"
require "option_parser"
require "yaml"

# Ambatch processes a yml file, turns each item into a String and passes the
# results to the command line. Useful for projects where you want to mock up
# a structure without commiting to use the generators ahead of time.
module Ambatch

  class Parser

    @commands = [] of String

    def self.parse_yaml(path : String)

      begin
        raise "Error: File not found." if !File.file? path
        raise "Error: File extension is not .yml" if File.extname(path).to_s == ".yml"
        data = YAML.parse(File.read path)
      rescue msg
        puts msg
      end
    end

    def self.stringify(yaml : YAML::Any | Nil)
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
          # TODO clean this parsing up
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
