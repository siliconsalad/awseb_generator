TEMPLATE_OPTION_VALUES = {
  updated_at: {
    value: Time.now.to_i * 1000
  },
  solution_stack: {
    values: [
      '64bit Amazon Linux 2015.03 v2.0.0 running Ruby 2.2 (Puma)',
      '64bit Amazon Linux 2015.03 v2.0.0 running Ruby 2.2 (Passenger Standalone)',
      '64bit Amazon Linux 2015.03 v2.0.0 running Ruby 2.1 (Puma)',
      '64bit Amazon Linux 2015.03 v2.0.0 running Ruby 2.1 (Passenger Standalone)',
      '64bit Amazon Linux 2015.03 v2.0.0 running Ruby 2.0 (Puma)',
      '64bit Amazon Linux 2015.03 v2.0.0 running Ruby 2.0 (Passenger Standalone)',
      '64bit Amazon Linux 2015.03 v2.0.0 running Ruby 1.9.3'
    ]
  },
  ec2_instance_type: {
    values: [
      't2.micro',
      't2.small',
      't2.medium',
      't2.large',
      'm3.medium',
      'm3.large',
      'm3.xlarge',
      'm3.2xlarge',
      'c3.large',
      'c3.xlarge',
      'c3.2xlarge',
      'c3.4xlarge',
      'c3.8xlarge',
      't1.micro',
      'm1.small',
      'm1.medium',
      'm1.large',
      'm1.xlarge',
      'c1.medium',
      'c1.xlarge',
      'c4.large',
      'c4.xlarge',
      'c4.2xlarge',
      'c4.4xlarge',
      'c4.8xlarge',
      'm2.xlarge',
      'm2.2xlarge',
      'm2.4xlarge',
      'm4.large',
      'm4.xlarge',
      'm4.2xlarge',
      'm4.4xlarge',
      'm4.10xlarge',
      'cc2.8xlarge',
      'hi1.4xlarge',
      'hs1.8xlarge',
      'cr1.8xlarge',
      'g2.2xlarge',
      'g2.8xlarge',
      'i2.xlarge',
      'i2.2xlarge',
      'i2.4xlarge',
      'i2.8xlarge',
      'r3.large',
      'r3.xlarge',
      'r3.2xlarge',
      'r3.4xlarge',
      'r3.8xlarge'
    ]
  },
  db_instance_type: {
    values: [
      'db.t2.micro',
      'db.t2.small',
      'db.t2.medium',
      'db.m3.medium',
      'db.m3.large',
      'db.m3.xlarge',
      'db.m3.2xlarge',
      'db.r3.large',
      'db.r3.xlarge',
      'db.r3.2xlarge',
      'db.r3.4xlarge',
      'db.r3.8xlarge',
      'db.m2.xlarge',
      'db.m2.2xlarge',
      'db.m2.4xlarge',
      'db.cr1.8xlarge',
      'db.m1.small',
      'db.m1.medium',
      'db.m1.large',
      'db.m1.xlarge',
      'db.t1.micro'
    ]
  },
  db_multi_az: {
    values: ['true', 'false']
  },
  db_storage: {
    type: 'Integer',
    default: 5,
    min: 5,
    max: 999
  },
  db_password: {
    validation: /^[a-zA-Z0-9]{8,16}$/i,
  },
  db_user: {
    validation: /^[a-zA-Z0-9]{8,16}$/i,
  },
  autoscaling_min_size: {
    type: 'Integer',
    default: 1,
    min: 1,
    max: 20
  },
  autoscaling_max_size:  {
    type: 'Integer',
    default: 2,
    min: 1,
    max: 20
  },
  rails_secret: {
    default: SecureRandom.hex(64)
  }
}
