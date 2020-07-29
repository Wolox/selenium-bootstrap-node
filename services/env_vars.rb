require 'dotenv/load'

module EnvVars
  DEFAULTS = {
    'BROWSER': 'chrome',
    'PLATFORM': 'desktop',
    'APP_PATH': 'www.google.com'
  }.freeze
  def get_env(var)
    env_var = ENV.fetch(var.upcase, DEFAULTS[:"#{var.upcase}"])
    raise "Env var #{var} is not defined" if env_var.nil?

    env_var
  end
end

World(EnvVars)
