require 'dotenv'

Dotenv.load

module EnvVars
  DEFAULTS = {
    'BROWSER': 'chrome',
    'PLATFORM': 'desktop'
  }.freeze
  def get_env(var)
    env_var = ENV.fetch(var.upcase, DEFAULTS[:"#{var.upcase}"])
    raise "Env var #{var} is not defined" if env_var.nil?

    env_var
  end
end

World(EnvVars)
