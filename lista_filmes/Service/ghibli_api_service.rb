# services/ghibli_api_service.rb
require 'httparty'
require 'json'
require_relative 'database_service'

class GhibliApiService
  API_URL = "https://ghibliapi.vercel.app/films".freeze

  def self.fetch_films
    response = HTTParty.get(API_URL)
    
    if response.success?
      JSON.parse(response.body)
    else
      puts "Erro na API: #{response.code} - #{response.message}"
      []
    end
  rescue StandardError => e
    puts "Erro ao conectar com a API: #{e.message}"
    []
  end

  def self.importar_filmes
    DatabaseService.execute("DELETE FROM films")
  
    films_data = fetch_films
    return 0 if films_data.empty?

    saved_count = 0
    films_data.each do |film_data|
      result = DatabaseService.insert_film(film_data)
      if result
        saved_count += 1
        puts " #{film_data['title']}"
      end
    end

    puts "\nTodos os #{saved_count} filmes foram importados/atualizados!"
    saved_count
  end
end