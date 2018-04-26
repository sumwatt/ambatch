require "./spec_helper"

describe Ambatch do

  describe "Ambatch::Parser.parse_yaml" do
    it "should return YAML::Any result" do
      path = "spec/support/good_file.yml"
      Ambatch::Parser.parse_yaml(path).should be_a(YAML::Any)
    end

    it "should throw an exception if the file is not found" do
      path = "spec/support/nofile.yml"
      expect_raises(Exception) {
        Ambatch::Parser.parse_yaml(path)
      }
    end

    it "should throw an exception if the file does not have .yml extension" do
      path = "spec/support/fake.txt"
      expect_raises(Exception) do
        Ambatch::Parser.parse_yaml(path)
      end
    end
  end

  describe "Ambatch::Parser.stringify" do
    it "should return Array result" do
      path = "spec/support/good_file.yml"
      result = Ambatch::Parser.parse_yaml(path)
      Ambatch::Parser.stringify(result).should be_a(Array(String))
    end

    it "should throw an exception if the file is not found" do
      path = "spec/support/nofile.yml"
      expect_raises(Exception, /Error/) do
        Ambatch::Parser.parse_yaml(path)
      end
    end

    it "should throw an exception if the file does not have .yml extension" do
      path = "spec/support/fake.txt"
      expect_raises(Exception, /Error/) do
        Ambatch::Parser.parse_yaml(path)
      end
    end
  end


end
