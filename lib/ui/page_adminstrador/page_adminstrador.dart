import 'package:flutter/material.dart';
import 'package:modulo_de_contagem/ui/page_adminstrador/novo_cliente/page_novo_cliente.dart';
import 'package:modulo_de_contagem/ui/page_adminstrador/novo_evento/page_novo_evento.dart';
import 'package:modulo_de_contagem/ui/page_adminstrador/novo_servico/page_novo_servico.dart';
import 'package:modulo_de_contagem/ui/page_adminstrador/novo_usuario/page_novo_usuario.dart';
import 'package:modulo_de_contagem/ui/page_adminstrador/widget/custom_card_view.dart';

class PageAdministrador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  _body(context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: <Widget>[
        CustomCardView(Icons.build, 'Novo Serviço', 0, 1, PageNovoServico()),
        CustomCardView(
            Icons.account_circle, 'Novo Cliente', 4, 5, PageNovoCliente()),
        CustomCardView(
            Icons.add_circle_outline, 'Novo Usuario', 3, 1, PageNovoUsuario()),
        CustomCardView(Icons.event, 'Novo Evento', 1, 4, PageNovoEvento()),
        CustomCardView(Icons.dashboard, 'Dashboard', 5, 2, PageNovoEvento()),
      ],
    );
  }
}
