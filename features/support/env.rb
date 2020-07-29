require 'rubygems'
require 'selenium-cucumber'
require 'selenium-webdriver'

relative_paths = ['/views/*.rb', '/services/*.rb']

full_paths = relative_paths.map { |relative_path| Dir.pwd << relative_path }

full_paths.each do |path|
  Dir[path].sort.each do |f|
    module_name = f.split('/').last.split('.')[0].capitalize
    module_name = module_name.gsub(/_(\w)/) { Regexp.last_match(1).upcase }
    require f
    include Kernel.const_get(module_name)
  end
end

platform ||= get_env('platform')
browser ||= get_env('browser')
app_path ||= get_env('app_path')
$is_headless ||= get_env('headless')

validate_parameters platform, browser, app_path

if %w[android iOS].include? platform
  browser = 'Browser' if browser == 'native'
  device_name, os_version = get_device_info if platform == 'android'
  desired_caps = {
    caps:       {
      platformName:  $platform,
      browserName: browser,
      versionNumber: $os_version,
      deviceName: $device_name,
      udid: $udid,
      app: ".//#{app_path}"
    }
  }

  begin
    $driver = Appium::Driver.new(desired_caps).start_driver
  rescue Exception => e
    puts e.message
    Process.exit(0)
  end
else
  begin
    chromedriver_path = File.join(File.absolute_path(''),"chromedriver")
    Selenium::WebDriver::Chrome.driver_path = chromedriver_path
    options = Selenium::WebDriver::Chrome::Options.new(args: ['--incognito', '--disable-popup-blocking', 'binary_location=/var/task/bin/headless-chromium'], prefs: { "disable-popup-blocking":"true"})
    if $is_headless == 'true'
      options.add_argument('--headless')
      options.add_argument('--disable-gpu')
      options.add_argument('--disable-dev-shm-usage')
      options.add_argument('--no-sandbox')
    end
    $driver = Selenium::WebDriver.for(:chrome, options: options)
    $driver.manage.window.maximize
  rescue Exception => e
    puts e.message
    Process.exit(0)
    $driver.quit
  end
end
