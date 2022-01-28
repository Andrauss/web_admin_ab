part of dashboard;

class _HeaderWeeklyTask extends StatelessWidget {
  _HeaderWeeklyTask({Key? key}) : super(key: key);

  var dashController = Get.put(DashboardController());
  var modelPesquisa = {};

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const HeaderText("Empresas"),
        const Spacer(),
        // _buildArchive(),
        const SizedBox(width: 10),
        _buildAddNewButton(),
      ],
    );
  }

  Widget _buildAddNewButton() {
    return ElevatedButton.icon(
      icon: const Icon(
        EvaIcons.list,
        size: 16,
      ),
      onPressed: () {
        _buidlFormFiltros();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
      ),
      label: const Text("Filtro"),
    );
  }

  TextEditingController cpnjController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  var maskTelefone = new MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
  var maskCPF = new MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  var maskCNPJ = new MaskTextInputFormatter(
      mask: '##.###.###/####-##', filter: {"#": RegExp(r'[0-9]')});

  RxBool emailValido = true.obs;
  RxDouble heightForm = 50.0.obs;
  RxBool isCPF = false.obs;

  limpaDados() {
    cpnjController.clear();
    nomeController.clear();
    emailController.clear();
    telefoneController.clear();
    emailValido.value = true;
    heightForm.value = 50.0;
  }

  _buidlFormFiltros() {
    limpaDados();

    return Get.dialog(AlertDialog(
      content: Obx(
        () => Container(
            height: emailValido.value == true ? 200 : 230,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                  child: TextField(
                    controller: nomeController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome',
                        labelStyle: TextStyle(fontSize: 15),
                        ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 8,
                          child: isCPF.value == false
                              ? TextField(
                                  controller: cpnjController,
                                  inputFormatters: [maskCNPJ],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'CNPJ',
                                      labelStyle: TextStyle(fontSize: 15)),
                                )
                              : TextField(
                                  controller: cpnjController,
                                  inputFormatters: [maskCPF],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'CPF',
                                      labelStyle: TextStyle(fontSize: 15)),
                                ),
                        ),
                        SizedBox(width: 1),
                        Flexible(
                          flex: 2,
                          child: Obx(() => InkWell(
                                onTap: () {
                                  if (isCPF.value == true) {
                                    isCPF.value = false;
                                  } else {
                                    isCPF.value = true;
                                  }
                                  cpnjController.clear();
                                  print('isCPF marcado: ${isCPF.value}');
                                },
                                child: Container(
                                    height: 50,
                                  
                                    decoration: BoxDecoration(
                                      color: isCPF.value == true
                                          ? Colors.grey[500]
                                          : Colors.transparent,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    width: 70,

                                    child: Center(
                                      child: Text(
                                        'CPF',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: isCPF.value == true
                                                ? Colors.white
                                                : Colors.black54),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              )),
                        )
                      ],
                    )),
                Container(
                  height: heightForm.value,
                  padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 15),
                        errorText: !emailValido.value
                            ? 'Informe um email válido!'
                            : null),
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                  child: TextField(
                    controller: telefoneController,
                    inputFormatters: [maskTelefone],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Telefone',
                        labelStyle: TextStyle(fontSize: 15)),
                  ),
                ),
              ],
            )),
      ),
      title: Text(
        'Filtro de empresa',
        textAlign: TextAlign.center,
      ),
      actions: [
        RaisedButton(
          child: Text('Fechar'),
          onPressed: () => {Get.back(result: true)},
          // ** result: returns this value up the call stack **
        ),
        RaisedButton(
          child: Text('Pesquisar'),
          onPressed: () {
            //Validar email
            if (emailController.text.trim().isNotEmpty) {
              var ret = Utils().validateEmail(emailController.text);
              print('email validation restonro');
              print(ret);
              if (ret != null) {
                heightForm.value = 70.0;
                emailValido.value = false;
                return;
              }
            }

            modelPesquisa = {
              "cnpjCpf": cpnjController.text,
              "email": emailController.text,
              "equipeId": null,
              "estado": null,
              "id": null,
              "telefone": telefoneController.text,
              "nome": nomeController.text
            };

            if (cpnjController.text.trim().isEmpty &&
                emailController.text.trim().isEmpty &&
                telefoneController.text.trim().isEmpty &&
                nomeController.text.trim().isEmpty) {
              Get.dialog(Container(
                height: 50,
                child: AlertDialog(
                  title: Text(
                    'Atenção',
                    textAlign: TextAlign.center,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Mdi.alert,
                        color: Colors.amberAccent,
                        size: 40,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Preencha um campo para pesquisar!')
                    ],
                  ),
                  actions: [
                    RaisedButton(
                        child: Text('Fechar'),
                        onPressed: () {
                          Get.back();
                        })
                  ],
                ),
              ));
              return;
            }

            dashController.searcEmpresaPesquisaByModel(modelPesquisa);

            cpnjController.clear();
            emailController.clear();
            telefoneController.clear();
            nomeController.clear();
            Get.back(result: true);
          },
          // ** result: returns this value up the call stack **
        ),
      ],
    ));
  }

  Widget _buildArchive() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[100],
        onPrimary: Colors.grey[850],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
      ),
      child: const Text("Archive"),
    );
  }
}
