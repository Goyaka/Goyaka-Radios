APP_CONFIG = {}

file_path = Rails.root.join("config/facebook.yml")
if File.exists? file_path
  yaml_data = YAML.load_file(file_path)
  APP_CONFIG = yaml_data
end