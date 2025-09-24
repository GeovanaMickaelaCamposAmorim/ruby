require_relative '../Service/database_service'
require_relative '../Service/ghibli_api_service'

class App
  def initialize
    DatabaseService.connect
    DatabaseService.create_table
  end

  def importar_filmes
    puts " Conectando à API do Studio Ghibli..."
    GhibliApiService.importar_filmes
  end

  def listar_todos
    films = DatabaseService.select_all_films
    exibir_filmes(films, "Todos os Filmes")
  end

  def buscar_por_titulo
    print "Digite o título (ou parte): "
    titulo = gets.chomp.strip
    
    if titulo.empty?
      puts " Título não pode estar vazio!"
      return
    end

    films = DatabaseService.search_by_title(titulo)
    exibir_filmes(films, "Busca por: '#{titulo}'")
  end

  def buscar_por_diretor
    print "Digite o nome do diretor: "
    diretor = gets.chomp.strip
    
    if diretor.empty?
      puts "Nome do diretor não pode estar vazio!"
      return
    end

    films = DatabaseService.search_by_director(diretor)
    exibir_filmes(films, "Filmes do diretor: '#{diretor}'")
  end

  def buscar_por_ano
    print " Digite o ano (ex: 2001): "
    ano = gets.chomp.strip
    
    unless ano.match?(/^\d{4}$/)
      puts " Ano inválido! Use formato: 1997"
      return
    end

    films = DatabaseService.search_by_year(ano)
    exibir_filmes(films, "Filmes do ano: #{ano}")
  end

  def top_avaliados
    films = DatabaseService.get_highest_rated(5)
    exibir_filmes(films, "Top 5 Filmes Mais Bem Avaliados")
  end

  def estatisticas
    stats = DatabaseService.get_statistics
    return puts "Nenhum dado encontrado." unless stats

    puts "\n ----ESTATÍSTICAS GERAIS----"
    puts " Total de filmes: #{stats['total']}"
    puts " Média de avaliação: #{stats['media'].to_f.round(1)}%"
    puts " Ano mais recente: #{stats['mais_novo']}"
    puts " Ano mais antigo: #{stats['mais_antigo']}"
  end

  def fechar_conexao
    DatabaseService.close
  end

  private

  def exibir_filmes(films, titulo)
    if films.any?
      puts "\n" + "="*70
      puts " #{titulo} - #{films.count} encontrado(s)"
      puts "="*70
      
      films.each_with_index do |film, index|
        puts "#{index + 1}. #{film['title']} (#{film['release_year']})"
        puts "   Diretor: #{film['director']} | Duração: #{film['running_time']}min | ⭐ #{film['rt_score']}%"
        puts "   Descrição: #{film['description']&.slice(0, 100)}..."
        puts "-" * 70
      end
    else
      puts " Nenhum filme encontrado."
    end
  end
end