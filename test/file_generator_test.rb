require 'test_helper'
require 'tmpdir'

require 'nomadize/file_generator'

class FileGeneratorTest < Minitest::Test

  def test_it_creates_a_file_with_the_timestamped_name
    file_name = 'create_some_table'
    timestamp = '20151108180211'

    Dir.mktmpdir('nomadize_file_generator_test') do |path|
      generator = Nomadize::FileGenerator.new(path: path, name: file_name, timestamp: timestamp)
      generator.save
      assert File.exists?(File.join(path, "#{timestamp}_#{file_name}.yml"))
    end
  end

  def test_writes_yml_outline_to_file
    file_name = 'create_some_table'
    timestamp = '20151108180211'

    Dir.mktmpdir('nomadize_file_generator_test') do |path|
      generator = Nomadize::FileGenerator.new(path: path, name: file_name, timestamp: timestamp)
      generator.save
      assert_equal({ up: "", down: "" }, File.open(File.join(path, "#{timestamp}_#{file_name}.yml")) { |f| YAML.load(f) })
    end
  end

end
