desc "Generate ElasticBeanstalk configuration template"
namespace :awseb do
  task :generate_config_template do

    require 'securerandom'
    require 'highline/import'
    require 'yaml'
    require 'aws-sdk'
    require 'aws-sdk-resources'
    require 'json'

    templates_path                 = File.dirname(__FILE__) + '/templates/'
    elasticbeanstalk_template_path = "#{templates_path}elasticbeanstalk.template"
    elasticache_template_path      = "#{templates_path}elasticache.template"
    template_option_values_path    = "#{templates_path}template_option_values.rb"

    application_name               = Rails.application.class.to_s.split('::').first

    unless File.exist?(elasticbeanstalk_template_path) && File.exist?(elasticache_template_path) && File.exist?(template_option_values_path)
      puts "Missing templates..."
      exit
    end

    # Load options values
    require "#{templates_path}template_option_values.rb"
    require "#{File.dirname(__FILE__)}/helpers.rb"

    configuration_template_name   = ask "Type the configuration template name : "
    configuration_template_name ||= application_name

    if File.exist?('./.elasticbeanstalk')
      generated_configuration_template_path = "./.elasticbeanstalk/#{configuration_template_name}.cfg.yml"
    else
      Dir.mkdir('./generated_templates')
      generated_configuration_template_path = "./generated_templates/#{configuration_template_name}.cfg.yml"
    end

    ## Generate configuration file
    configuration_template_file = File.new(generated_configuration_template_path, 'w')

    File.open(elasticbeanstalk_template_path).each do |line|
      ## Line contains variable to replace
      if line.match(/{{([a-zA-Z\_]*)}}/i)
        result                  = ''
        variable_name           = line.match(/{{([a-zA-Z\-\_]*)}}/i)[0]
        cleaned_variable_name   = variable_name.gsub(/({|})/i, '')
        formatted_variable_name = cleaned_variable_name.gsub(/\_/i, ' ')

        ## Available values list
        if TEMPLATE_OPTION_VALUES.has_key?(cleaned_variable_name.to_sym) && TEMPLATE_OPTION_VALUES[cleaned_variable_name.to_sym][:values]
          result = ask_from_select(formatted_variable_name, TEMPLATE_OPTION_VALUES[cleaned_variable_name.to_sym][:values])
        ## Specific values
        elsif TEMPLATE_OPTION_VALUES.has_key?(cleaned_variable_name.to_sym)
          result = ask_value(TEMPLATE_OPTION_VALUES[cleaned_variable_name.to_sym], cleaned_variable_name, formatted_variable_name)
        ## Default case
        else
          result = ask "#{formatted_variable_name} ? "
        end

        configuration_template_file.puts line.gsub(/{{([a-zA-Z\-\_]*)}}/i, result.to_s)
      else
        configuration_template_file.puts line
      end
    end

    elasticache_questions('redis', elasticache_template_path, configuration_template_file)
    elasticache_questions('memcached', elasticache_template_path, configuration_template_file)

    configuration_template_file.close
  end
end
