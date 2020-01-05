import 'package:flutter/material.dart';
import 'package:modulo_de_contagem/ui/commons/widget/custom_date_picker.dart';
import 'package:modulo_de_contagem/ui/commons/widget/custom_picker_file.dart';
import 'package:modulo_de_contagem/ui/page_adminstrador/novo_evento/bloc_novo_evento.dart';
import 'package:modulo_de_contagem/ui/page_adminstrador/novo_servico/widget/custom_drop_down.dart';

class PageNovoEvento extends StatefulWidget {
  @override
  PageNovoEventoState createState() => PageNovoEventoState();
}

class PageNovoEventoState extends State<PageNovoEvento> {
  final _formKey = GlobalKey<FormState>();
  BlocNovoEvento bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocNovoEvento(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        // Title
        title: Text("Novo Evento Teste"),
      ),
      // Body
      body: Form(
        key: _formKey,
        child: Container(
            child: Stepper(
          currentStep: bloc.step,
          steps: [
            Step(
                state: bloc.step > 0 ? StepState.complete : StepState.indexed,
                // Title of the Step
                title: Text("Selecione a data do evento"),
                // Content, it can be any widget here. Using basic Text for this example
                content: CustomDatePicker(
                  onSelectedDate: (date) {
                    bloc.dateTime = date;
                  },
                ),
                isActive: bloc.step == 0),
            Step(
                state: bloc.step > 1 ? StepState.complete : StepState.indexed,
                title: Text("Selecione o cliente"),
                content: CustomDropDown(
                    lista: [
                      'Magazine',
                      'Carrefour',
                      'Uol',
                      'Guerras nas estrelas'
                    ],
                    hint: 'Cliente',
                    onSelectedItem: (select) {
                      bloc.cliente = select;
                    }),
                // You can change the style of the step icon i.e number, editing, etc.
                isActive: bloc.step == 1),
            Step(
                state: bloc.step > 2 ? StepState.complete : StepState.indexed,
                title: Text("Selecione a unidade"),
                content: CustomDropDown(
                    lista: ['Base 1', 'Base 2', 'Base 3'],
                    hint: 'Unidade',
                    onSelectedItem: (select) {
                      bloc.filial = select;
                    }),
                isActive: bloc.step == 2),
            Step(
                state: bloc.step > 3 ? StepState.complete : StepState.indexed,
                title: Text("Selecione o tipo de serviço"),
                content: CustomDropDown(
                    lista: ['Iventario', 'Auditoria', 'Inspeção'],
                    hint: 'Serviço',
                    onSelectedItem: (select) {
                      bloc.tipoServico = select;
                    }),
                isActive: bloc.step == 3),
            Step(
                state: bloc.step > 4 ? StepState.complete : StepState.indexed,
                title: Text("Selecione a base de dados"),
                content: CustomPickerFile(
                  title: 'Base de Dados',
                  onSelectedPathFile: (path) {
                    bloc.pathBaseDados = path;
                  },
                ),
                isActive: bloc.step == 4),
          ],
          type: StepperType.vertical,
          onStepCancel: () {
            setState(() {
              bloc.stepCancel();
            });
          },
          onStepContinue: () {
            setState(() {
              bloc.stepContinue();
            });
          },
        )),
      ),
    );
  }
}
