import 'package:flutter/material.dart';
import 'package:flutter_pagination/widgets/cs_progress_indicator.dart';
import 'package:flutter_pagination/widgets/scroll_pagination.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  List<String> items = []; //Registros que serão exibidos na view

  bool loading = false; //Para indicar se está sendo carregado algo ou não
  bool finishLoading = false; //Para controlar se há mais dados a serem carregados ou não
  int page = 0; //Variável para controlar a paginação. Começa sempre em 0

  @override
  void initState() {
    super.initState();

    _fetchItems();
  }

  ///Função que seria responsável por buscar os dados a serem exibidos
  void _fetchItems() async {
    try {
      setState(() {
        //Atualiza o estado para indicar que está buscando informações
        loading = true;
      });

      //Busca os registros de um repositório, banco de dados,...
      final registers = await _generateItems(page);

      //Adiciona os registros recebidos em 'items'. Lista que está sendo utilizada para exibir os registros na view
      items.addAll(registers);

      //Caso a lista de registros estiver vazia, indica que houve o fim do carregamento (não há mais registros para buscar)
      finishLoading = registers.isEmpty;

      //Incrementa a página a ser pesquisada
      //Importante fazer isso apenas após a pesquisa dos registros
      //Na segunda vez, será a página 1 e assim por adiante
      page++;
    } catch (_) {
    } finally {
      //Ao final de tudo, termina com a indicação de carregamento
      setState(() {
        loading = false;
      });
    }
  }

  ///Função fake apenas para reproduzir uma geração de dados
  Future<List<String>> _generateItems(int page) async {
    await Future.delayed(const Duration(seconds: 2)); //Delay apenas para simular uma requisição

    //Forçando retornar uma lista vazia, para simular o fim da paginação
    if (page == 4) {
      return [];
    }

    //Retornando 20 itens a cada paginação
    return List.generate(20, (index) => 'Page ${page + 1} - Index: $index');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Pagination'),
        centerTitle: true,
      ),
      body: ScrollPagination(
        loading: loading,
        isFinish: finishLoading,
        callback: _fetchItems,
        child: ListView.builder(
          itemCount: items.length + (loading ? 1 : 0),
          itemBuilder: (_, index) {
            if (index < items.length) {
              final item = items[index];

              return Card(
                margin: const EdgeInsets.all(5),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(item),
                ),
              );
            }

            return const CsProgressIndicator();
          },
        ),
      ),
    );
  }
}
