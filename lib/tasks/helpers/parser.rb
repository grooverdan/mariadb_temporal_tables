require 'optparse'

# Usage of names arguments in Rake as shown here: http://www.mikeball.us/blog/rake-option-parser/
module Parser
  def parse_options(command)
    options = {}
    option_parser = OptionParser.new
    option_parser.banner = "Usage: rake #{command} [options]"

    case command
    when "mariadb_temporal_tables:gen_migration_application"
      setup_parser_for_gen_migration_application(option_parser, options)
    else
      raise "Unable to parse options for unknown command: #{command}"
    end

    args = option_parser.order!(ARGV) {}
    option_parser.parse!(args)
    options
  end

  private

  def setup_parser_for_gen_migration_application(parser, options)
    parser.on("-tTABLE", "--table=TABLE","Table to generate migration for") do |value|
      options[:table_name] = value
    end

    parser.on("-acADD", "--add_columns=ADD","Whether columns should be added to table or not") do |value|
      options[:add_columns] = value
    end

    parser.on("-scnNAME", "--start_column_name=NAME","Name of column that represents start of period") do |value|
      options[:start_column_name] = value
    end

    parser.on("-ecnNAME", "--end_column_name=NAME","Name of column that represents end of period") do |value|
      options[:end_column_name] = value
    end

    parser.on("-rpkREPLACE", "--replace_primary_key=REPLACE","Whether end column should be added to primary key or not") do |value|
      options[:replace_primary_key] = value
    end

    parser.on("-ctTYPE", "--column_type=TYPE","Type to use for column to be added") do |value|
      options[:column_type] = value
    end
  end

end
