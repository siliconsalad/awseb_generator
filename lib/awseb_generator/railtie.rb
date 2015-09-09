require 'awseb_generator'
require 'rails'

module AwsebGenerator
  class Railtie < Rails::Railtie
    railtie_name :awseb_generator

    rake_tasks do
      load "tasks/awseb_generator.rake"
    end
  end
end
