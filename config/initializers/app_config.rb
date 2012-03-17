APP_CONFIG = {}

file_path = Rails.root.join("config/facebook.yml")
if File.exists? file_path
  yaml_data = YAML.load_file(file_path)
  APP_CONFIG = yaml_data
else
  # hack to make it work in heroku
  APP_CONFIG['group_id'] = 187054981393266
  APP_CONFIG['access_token'] = ENV['FACEBOOK_ACCESS_TOKEN']
end