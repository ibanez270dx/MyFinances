
path = File.join(Rails.root, '/config/accounts.yml')
ACCOUNT_CONFIGS = YAML.load(File.read(path)).with_indifferent_access
