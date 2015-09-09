def ask_from_select(variable, values=[])
  choose do |menu|
    menu.prompt = "#{variable} ? "

    values.each do |available_value|
      menu.choice(available_value) { return available_value }
    end
  end
end

def ask_value(variable_informations, variable_name, formatted_variable_name, validation_error=false)
  value      = variable_informations[:value]
  type       = variable_informations[:type]
  min        = variable_informations[:min]
  max        = variable_informations[:max]
  default    = variable_informations[:default]
  validation = variable_informations[:validation]

  question   = "#{formatted_variable_name} ? #{default ? "(#{default})" : ''}"

  if value
    result = value
  elsif type
    result = ask(question, Object.const_get(type)) do |q|
      q.in      = min..max if min && max && type == 'Integer'
      q.default = default if default
    end
  else
    result  = ask(question) do |q|
      q.in       = min..max if min && max && type == 'Integer'
      q.default  = default if default
      q.validate = validation if validation

      if variable_name.match(/password/i)
        q.echo         = "*"
        q.verify_match = true
        q.gather       = {
          "Enter a password"                      => '',
          "Please type it again for verification" => ''
        }
        q.responses[:mismatch] = "Password confirmation doesn't match... Try again."
      end
    end
  end

  return result
end

def elasticache_questions(kind, elasticache_template_path, configuration_template_file)
  choose do |menu|
    menu.prompt = "Do you want to add a #{kind.capitalize} cluster ?"

    menu.choice(:true) do
      File.open(elasticache_template_path).each do |line|
        if line.match(/{{([a-zA-Z\_]*)}}/i)
          result                  = ''
          variable_name           = "#{kind}_#{line.match(/{{([a-zA-Z\-\_]*)}}/i)[0]}"
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
    end

    menu.choices(:false)
  end
end
