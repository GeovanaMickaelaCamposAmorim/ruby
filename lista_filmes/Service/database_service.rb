# services/database_service.rb
require 'pg'

class DatabaseService
  # Configurações do banco - altere conforme seu PostgreSQL
  DB_CONFIG = {
    host: 'localhost',
    port: 5000,
    dbname: 'ghibli_films',
    user: 'postgres',
    password: '12345678'
  }.freeze

  def self.connect
    @connection ||= PG.connect(DB_CONFIG)
  rescue PG::Error => e
    puts " Erro ao conectar com o banco: #{e.message}"
    nil
  end

  def self.close
    @connection&.close
    @connection = nil
    puts " Conexão com o banco fechada."
  end

  def self.connection
    @connection || connect
  end

  def self.create_table
    conn = connection
    return unless conn

    conn.exec(%q{
      CREATE TABLE IF NOT EXISTS films (
        id SERIAL PRIMARY KEY,
        ghibli_id VARCHAR(50) UNIQUE NOT NULL,
        title VARCHAR(255) NOT NULL,
        original_title VARCHAR(255),
        original_title_romanised VARCHAR(255),
        description TEXT,
        director VARCHAR(100),
        producer VARCHAR(100),
        release_year INTEGER,
        running_time INTEGER,
        rt_score INTEGER,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    })
    puts "✅ Tabela 'films' criada/verificada com sucesso!"
  rescue PG::Error => e
    puts "❌ Erro ao criar tabela: #{e.message}"
  end

  # Métodos para operações no banco
  def self.execute(query, params = [])
    conn = connection
    return [] unless conn

    conn.exec_params(query, params)
  rescue PG::Error => e
    puts "❌ Erro na consulta: #{e.message}"
    []
  end

  def self.insert_film(film_data)
    query = %q{
      INSERT INTO films (
        ghibli_id, title, original_title, original_title_romanised,
        description, director, producer, release_year, running_time, rt_score
      ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
      ON CONFLICT (ghibli_id) DO UPDATE SET
        title = EXCLUDED.title,
        description = EXCLUDED.description,
        rt_score = EXCLUDED.rt_score
    }

    execute(query, [
      film_data['id'],
      film_data['title'],
      film_data['original_title'],
      film_data['original_title_romanised'],
      film_data['description'],
      film_data['director'],
      film_data['producer'],
      film_data['release_date'].to_i,
      film_data['running_time'].to_i,
      film_data['rt_score'].to_i
    ])
  end

  def self.select_all_films
    execute("SELECT * FROM films ORDER BY release_year DESC")
  end

  def self.search_by_title(title)
    execute("SELECT * FROM films WHERE title ILIKE $1 ORDER BY title", ["%#{title}%"])
  end

  def self.search_by_director(director)
    execute("SELECT * FROM films WHERE director ILIKE $1 ORDER BY release_year", ["%#{director}%"])
  end

  def self.search_by_year(year)
    execute("SELECT * FROM films WHERE release_year = $1 ORDER BY title", [year.to_i])
  end

  def self.get_highest_rated(limit = 5)
    execute("SELECT * FROM films WHERE rt_score > 0 ORDER BY rt_score DESC LIMIT $1", [limit])
  end

  def self.get_statistics
    result = execute("SELECT COUNT(*) as total, AVG(rt_score) as media, MAX(release_year) as mais_novo, MIN(release_year) as mais_antigo FROM films")
    result[0] if result.any?
  end
end