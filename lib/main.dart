import 'package:flutter/material.dart';
// Importa o pacote do Flutter que traz os widgets:
// MaterialApp, Scaffold, AppBar, Text e entre outros.
// Sem esse import nenhum desses widgets existirá no arquivo. 

void main(){
  // Ponto de Entrada do programa dart (primeira função a ser sexecutada) quando o app roda
  runApp(const CrachaApp());
  // runAPP liga o motor do Flutter para entregar o widget raíz (CrachaApp) que será desenhado na tela.
  // O Const especifica que o widget pode ser construido em tempo de compilação.
}
class CrachaApp extends StatelessWidget{
  // Extends Statelesswidget signifca que a classe herda o comportamento de um widget 'sem memória'.
  // Ele desce a tela, mas não guarda nehum dado que muda sozinho, porque nome ou cargo são fixos durante o uso do app.
  const CrachaApp({super.key});
  // Construtor da Classe. 'super.key' repassa o parâmetro key para a classe pai para identificar o widget dentro da árvore.
  // Exemplo: Imagine que você tem uma lista de tarefas na tela do celular e decide apagar a primeira tarefa.
  // Como o Flutter sabe qual tarefa ele deve destruir e quais manter? Ele sabe porque cada widget tem uma 'key que é única'
  @override
  // Avisa ao compiulador: este método já existe na classe pai.
  // (StatellessWidget) e estou reescrevendo o comportamento dele. 
  Widget build(BuildContext context) {
    // build() é o méotod obrigatório chamado pelo Flutter para desenhar a interface. 
    // Recebe um BuildContex (o 'endereço' deste widget na árvore e deve retornar o widget pronto).
    return MaterialApp(
      // Wdiget raíz que congiura o aplicativo inteiro! tema, título, tela inicial, e o visual.
      debugShowCheckedModeBanner: false,
      // Remove a faixa vermleha 'DEBUG' do canto da tela - só estética.
      title: 'Crachá Digital',
      // Título interno do APP, não aparece na tela.
      home: Scaffold(
        // Home define a tela real do app. Scaffold cria o esqueleto padrão, que já reserva espaço para AppBar e corpo, por exemplo.
        appBar: AppBar(
          // Região Fixa no topo da tela.
          title: const Text('Crachá Digital'),
          // Texto exibido dentro da AppBar, cosnt porque nunca vai mudar.
          // Então Flutter pode reaproveitar esse widget sem criar o título a cada 'redesenho'.
        ),
        body: Padding(
          // Body é a região principal da página, abaixo de AppBar.
          // Padding cria espaço interno ao redor do seu conteúdo.
          padding: const EdgeInsets.all(24),
          // 24 Pixels de 'respiro' nos 4 lados, entre a borda da tela e o conteúdo.
          child: Column(
            // Column empilha seus filhos verticalmente. primeiro o cartão do crachá, depois o botão.
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // Controla o eixo da coluna horizontal. 'Stretch' faz cada filho ocupar toda a largura disponivel.
            //É por isso que o cartão e o botão vão preencher a largura da tela, em vez de ficarem do tamanho especifico de seu conteudo.
            children: [
              // Aqui faremos a lista de filhos da coluna
              Container(
                // Container é a "caixa" que dará a aparencia de cartão ao conjunto de textos
                padding: const EdgeInsets.all(16),
                //Espaco interno do container. distancia entre a borda do cartao e o conteudo dentro
                decoration: BoxDecoration(
                  // Cuida da aparencia da caixa
                  color: Colors.blue,
                  // Pinta o fundo do conteiner
                  borderRadius: BorderRadius.circular(12),
                  // Arredonda os 4 cantos do container com um raio de 12 pixels
                  border: Border.all(color: Colors.blue.shade50),
                  //Desenha um contorno fino ao redor do conteiner
                ),
                child: const Column(
                  // O container tmb so aceita um filho - aqui, uma column propia, local a este cartao
                  // Const pq nada aqui dentro vai mudar em tempo de execucao
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //dentro do cartao, o alinhamento a esquerda - uma column diferente pode ter configuracao diferente da colunm externa
                  children: [
                    //Faremos a lista de filhos da coluna
                    Text('Misael Morgado', style: TextStyle(
                      fontSize: 28,
                      // tamanho da fonte em pixels - bem grande
                      fontWeight: FontWeight.bold,                    
                    ),
                    ),
                    SizedBox(height: 4),
                    //Widget invisivel que adiciona um espaco vertical de 4 pixels entre nome e o cargo
                    Text('Tecnico de manutenção',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 4),
                    //Widget invisivel que adiciona um espaco vertical de 4 pixels entre cargo e o resto da column
                    Row(
                      //Row organiza seus filhos lado a lado, nahorizontal, difrente da column
                      children: [
                        Icon(Icons.factory, color: Colors.blue),
                        //icon e apenas um desenho vetorial da biblioteca material
                        //puramente visual. Aqui um icone da frabica
                        SizedBox(width: 8),
                        //Dentro da row, sizedbox(width:) cria um espaço horizontal entre o icone e o texto
                        Text('Setor: Manuteção Industrial'),
                        //Texto final da row
                      ],
                    ) 
                  ],
                )
              ),
              const SizedBox(height: 24),
              //Espaço vertical entre o cartão e o botão
              FilledButton.icon(
                //Tipo de botão que já etá preenchido icone + texto, lado a lado sem precisar montar uma row manual para ele
                onPressed: (){
                  //Ação de callback executada toda vez que o botão é tocado
                  //Aqui usamos uma função anônima
                  ScaffoldMessenger.of(context).showSnackBar(
                    // Context é o endereço deste widget denro da arvore
                    //.showSnackBar pede para esse scarffold exibir um aviso
                    const SnackBar(
                      //Snackbar é o aviso que desliza na parte inferior, mostra a mensagem por alguns segundos
                      content: Text('Acesso Liberado!')
                    ),
                  );
                }, 
                icon: const Icon(Icons.lock_open),
                // Icone exibido á esquerda do texto do botão, neste caso, um cadeado
                label: Text('Acesso liberado!')
              )
            ],
          )
        )
      ),
    );
  }
}