require "./ambatch/*"
require "option_parser"
require "yaml"


OptionParser.parse! do |parser|
  parser.banner = "Usage: ambatch -f /path/to/file.yml"
  parser.on "-f PATH", "--file PATH", "Path to a file" do |path|
    puts "ok"
    yaml = YAML.parse(File.read path).as_h
    commands = [] of String
    yaml.each do |action, names|
      names.as_h.each do |k, v|
        result = ""
        result += action.to_s.downcase + " " + k.to_s + " " + v.as_a.join(" ")
        commands.push(result)
      end
    end
    commands.each do |line|
      puts system "amber g " + line
    end

  end
  parser.on "-h", "--help", "Show this help" do
    puts parser
    exit 0
  end
  parser.on "-v", "--version", Ambatch::VERSION do
    puts Ambatch::VERSION
    exit 0
  end
end
