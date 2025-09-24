
require_relative 'funcoes/app'

def mostrar_menu
  puts "\n"
  puts "🌟 STUDIO GHIBLI FILMS DATABASE 🌟"
  puts "\n  ----MENU PRINCIPAL----"
  puts "1.  Importar filmes da API"
  puts "2.  Listar todos os filmes"
  puts "3.  Buscar por título"
  puts "4.  Buscar por diretor"
  puts "5.  Buscar por ano"
  puts "6.  Top 5 melhores avaliações"
  puts "7.  Estatísticas"
  puts "0.  Sair"
  print "\n Escolha uma opção: "
end

def limpar_tela
  system('clear') || system('cls')
end

def aguardar_enter
  print "\nPressione Enter para continuar..."
  gets
end

# Inicializar aplicação
app = App.new

begin
  loop do
    limpar_tela
    mostrar_menu
    opcao = gets.chomp.to_i

    case opcao
    when 1
      puts "\n IMPORTANDO FILMES..."
      app.importar_filmes
      aguardar_enter
      
    when 2
      puts "\n LISTANDO TODOS OS FILMES..."
      app.listar_todos
      aguardar_enter
      
    when 3
      puts "\n BUSCA POR TÍTULO"
      app.buscar_por_titulo
      aguardar_enter
      
    when 4
      puts "\n BUSCA POR DIRETOR"
      app.buscar_por_diretor
      aguardar_enter
      
    when 5
      puts "\n BUSCA POR ANO"
      app.buscar_por_ano
      aguardar_enter
      
    when 6
      puts "\n TOP 5 AVALIADOS"
      app.top_avaliados
      aguardar_enter
      
    when 7
      puts "\n ESTATÍSTICAS"
      app.estatisticas
      aguardar_enter
      
    when 0
      puts "\n✨ Obrigado por usar o Ghibli Films Database!"
      app.fechar_conexao
      break
      
    else
      puts "\n Opção inválida! Tente novamente."
      aguardar_enter
    end
  end
rescue Interrupt
  puts "\n\n Programa interrompido pelo usuário."
  app.fechar_conexao
rescue StandardError => e
  puts "\nErro inesperado: #{e.message}"
  app.fechar_conexao
end