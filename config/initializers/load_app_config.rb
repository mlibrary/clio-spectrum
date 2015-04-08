begin
  raw_config = File.read(Rails.root.to_s + '/config/app_config.yml')
  loaded_config = YAML.load(raw_config)
  all_config = loaded_config['_all_environments'] || {}
  env_config = loaded_config[Rails.env] || {}
  APP_CONFIG ||= all_config.merge(env_config)
rescue
  APP_CONFIG = {}
end

PERMISSIONS_CONFIG ||= YAML.load(File.read(Rails.root.to_s + '/config/permissions.yml'))
SOURCE_CONFIG ||= Spectrum::Config::SourceList.new(YAML.load(File.read(Rails.root.to_s + '/config/source.yml')))
FOCUS_CONFIG ||= Spectrum::Config::FocusList.new(YAML.load(File.read(Rails.root.to_s + '/config/focus.yml')))
SEARCHES_CONFIG ||= YAML.load(File.read(Rails.root.to_s + '/config/searches.yml'))
raw_config = File.read(Rails.root.to_s + '/config/marc_display_fields.yml')
marc_config = YAML.load(raw_config)
MARC_FIELDS ||= marc_config

SOLR_CONFIG ||= YAML.load(File.read(Rails.root.to_s + '/config/solr.yml'))
