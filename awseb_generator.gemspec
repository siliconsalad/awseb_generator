$:.push File.expand_path("../lib", __FILE__)

require "awseb_generator/version"

Gem::Specification.new do |s|
  s.name        = "awseb_generator"
  s.version     = AwsebGenerator::VERSION
  s.authors     = ["Alexandre Salaun"]
  s.email       = ["asalaun@siliconsalad.com"]
  s.homepage    = "https://github.com/siliconsalad/awseb_generator"
  s.summary     = "This gem add rake tasks to generate ElasticBeanstalk configuration templates."
  s.description = "This gem add rake tasks to generate ElasticBeanstalk configuration templates."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"
  s.add_dependency "aws-sdk"
  s.add_dependency "aws-sdk-resources"
  s.add_dependency "highline"
end
