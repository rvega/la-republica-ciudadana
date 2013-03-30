CONFIG_FILE = "config/config.yml"
PUNTAJES_CONFIG = YAML.load_file("#{Rails.root}/#{CONFIG_FILE}")["puntajes"]
