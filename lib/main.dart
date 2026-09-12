import 'package:flutter/material.dart';

void main() {
  runApp(const ContadorApp());
}

class ContadorApp extends StatelessWidget {
  // Essa classe é só uma casca de configuração do app
  // Ela não guarda nenhum dado
  const ContadorApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Monta e devolve a configuração geral do App
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Contador de inspeção",
      // Titulo interno do app
      home: const TelaContador(),
      // A tela inicial do app é o Widget TelaContador, definido logo abaixo.
    );
  }
}

class TelaContador extends StatefulWidget {
  // Isso é novo em relação ao projeto (Crachá)
  // Agora, a tela precisa lembrar de dados que mudam
  // a contagem, o nome digitado, o histórico. Esta classe ainda não está guardando nada sozinha, mas ela já declara que existe um state associado a ela.
  const TelaContador({super.key});

  @override
  State<TelaContador> createState() => _TelaContadorState();
  // createState é o método que o Flutter chama para criar o objeto de estado ligado a este widget.

}

class _TelaContadorState extends State<TelaContador>{
  // Esta é a classe que efetivamente guarda os dados que podem mudar durante o uso do app. Funciona como um cofre que entre um reconstrução e outra das tela.
  int _pecasAprovadas = 0;
  // Variável que guarda a contagem atual de peças aprovadas
  final _nomeController = TextEditingController();
  // TextEditingController é a ponte entre o que aparece na tela e o nosso código dart. Guarda o texto digitado e o permite lê-lo a qualquer momento em "nomeController.text". O final é pq o Controller em si nunca muda, quem muda é o texto dentro dele.
  final List<String>_resgistros = [];
  // Lista vazia de textos que vai guardar o histórico de registros de inspeção fechados no turno.
  void _aprovarPeca() {
    // Funçao chamada toda vez que o botão "+1 peça" é tocado pelo usuário
    setState(() {
      // Sempre que um dado do state muda, esta alteração precisa ocorrer dentro do SetState para que o Flutter saiba que precisa redesenhar a tela com o novo valor.
      _pecasAprovadas ++;
      // Incrementa a contagem de peças em 1 unidade.
      
    });
  }

  void _registrarEZerar() {
    // Funçar chamada quendo o botão "registrar e zerar" é tocado pelo usuário
    final nome = _nomeController.text.trim().isEmpty ? "Sem nome" : _nomeController.text.trim();
    // Operador ternário (condição ? valorVerdadeiro : valorFalso)
    //.trim remove espaços em branco do texto
    // Se, depois disso, o texto estiver vazio, usamos "não informado"; senão, usamos o nome digitado.
    setState(() {
      // Denovo , toda mudança do State entra no Set State
      _resgistros.add('$nome - $_pecasAprovadas peça(s)');
      // Monta um texto combinando o nome e a contagem atual
      _pecasAprovadas = 0;
      // Zera o contador, para o inspetor começa a contar o próximo lote de pecas;
    });
  }

  @override
  void dispose() {
    // Dispose é chamado pelo flutetr quando a tela é removida quando a tela removida da árvore de widgets, ou seja, quando o usuário sai da tela
    _nomeController.dispose();
    // Libera os recursos do recurso (evita deixar memória alocada / em uso)
    super.dispose();
    // Chama a implementação original / nativa do sispose da classe pai. Deve ser a sempre última linha da função dispose, para garantir que tudo seja limpo corretamente
  }

  @override
  Widget build(BuildContext context) {
    // Monta e desenvolve a árvore de widgets que representa a tela no estado ATUAL (com os valores atuais de _pecasAprovadas, nomeController.text e _registros)
    return Scaffold(
      // Esqueleto padrão de uma tela do Flutter
      appBar: AppBar(
        title: Text("Inspeção de Peças")
        // Título fixo da barra do topo da tela
      ),
      body: Padding(
        // Corpo da tela com espaçamento interno ao redor de todo o elemento
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // Organiza todo o conteúdo da tela verticalmente 
          children: [
            TextField(
              // Campo de texto onde o inspetor digita o nome dele
              controller: _nomeController,
              // Liga este compo ao controller declarado anteriormente, é assim que conseguimos ler o texto digitado
              decoration: const InputDecoration(
                labelText: "Nome do Inspetor do Turno",
                border: OutlineInputBorder(),
                // Desenha um controno ao redor da caixa de texto
              ),
              onChanged: (text) {
                // onChanged é chamado pelo Flutter toda vez que o usuário digita ou apagua um caracter.
                setState(() {
                  // Chamamos o setState com um bloco vazio só para forçar a tela a se redezenhar. O dado em si só não mudoum só foi atualizado pelo controller, só precisamos avisar o Flutter para reler esse valor no Text logo abaixo.

                });
              },
            ),
            const SizedBox(height: 16),
            // Espaço vertical entre o compo de texto e a linha de responsável

            Text(
              _nomeController.text.trim().isEmpty ? "Responsável: Não Informado" : "Responsável: ${_nomeController.text.trim()}",
              // Se o compo ainda está vazio, mostramos um aviso, senão mostramos o nome digitado - interpolado dentro do texto com ${}.
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 16),

            Text(
              '$_pecasAprovadas',
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              // Fonte bem grande e em negrita, para destacar o texto
            ),

            Row(
              // Linha horizontal com dois botões
              mainAxisAlignment: MainAxisAlignment.center,
              // Centraliza os botões no eixo principal da Row (horizontal)
              children: [
                FilledButton.icon(
                  // Este é um estilo de botão já preenchido, será aprovado para aprovar a peça
                  onPressed: _aprovarPeca,
                  // Quando tocado o botão chama a função AprovarPeca, essa é uma forma curta/abreviada de escrever: onPressed: (){_aprovarPeca();}
                  icon: const Icon(Icons.add),
                  label: const Text("+1 peça")
                ),
                const SizedBox(width: 12),

                OutlinedButton.icon(
                  onPressed: _registrarEZerar,
                  icon: const Icon(Icons.save_alt),
                  label: const Text("Registrar e Zerar"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Histórico do Turno",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _resgistros.isEmpty
                  ? const Center(child: Text("Nenhum registro ainda"))
                  : ListView.builder(
                      itemCount: _resgistros.length, 
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.history),
                            title: Text(_resgistros[index]),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}