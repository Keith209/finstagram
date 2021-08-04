configure do
  # Log queries to STDOUT in development
  if Sinatra::Application.development?
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end
  if Sinatra::Application.development?
    set :database, {
      adapter: "sqlite3",
      database: "db/db.sqlite3"
  }
  else
    db_url = 'postgress://[your_postgres_url here]'
    db = URI.parse(ENV['postgres://srwnopubluuwvm:01df8f3bda8d170b6410760ad1b7974b52149e6a5f927072e78b03100fa5fac1@ec2-18-214-195-34.compute-1.amazonaws.com:5432/d97ojqlc0k2vo8'] || db_url)
    set :database, {
      adapter: "postgresq1",
      host: db.host,
      username: db.user,
      password: db.password,
      database: db.path[1..-1],
      encoding: 'utf8'    
    }
  end
  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end

end
