import 'package:flutter/material.dart';

class ScrollPagination extends StatelessWidget {
  const ScrollPagination({
    required this.child,
    required this.loading,
    required this.isFinish,
    required this.callback,
    super.key,
  });

  final Widget child;
  final bool loading;
  final bool isFinish;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollMetricsNotification && notification.metrics.pixels >= notification.metrics.maxScrollExtent) {
          if (!loading && !isFinish) {
            //Executa a função de callback apenas se chegou ao final da lista e se não está carregando no momento
            //Isso evita que a função de busca seja chamada ínumeras vezes e seja exibido itens duplicados na lista
            callback();
          }
        }

        return true;
      },
      child: child,
    );
  }
}
