import 'package:agenda_beauty_online/app/model/PesquisaEmpresa.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmpresaDetail extends StatelessWidget {
  const EmpresaDetail({ Key? key, required this.empresa}) : super(key: key);
  
  final PesquisaEmpresa empresa;

  getFormatedDate(_date) {
    if (_date == null) {
      return "";
    }
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd/MM/yy');
    return outputFormat.format(inputDate);
  }

  @override
  Widget build(BuildContext context) {
      
      
    return DefaultTabController(
      length: 2,
      child: Container(
          height: Get.height,
          width: 350,
          child: Scaffold(
            
           appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child:  Container(
              // color: Colors.white54,
              child:  SafeArea(
                child: Column(
                  children: <Widget>[
                     Expanded(child: Container()),
                     TabBar(
                      tabs: [
                        const Text("Empresa",
                        style: TextStyle(color: Colors.black54),), 
                        const Text("Plano",
                        style: TextStyle(color: Colors.black54),), 
                        ],
                    ),
                  ],
                ),
              ),
            ),
          ),

            body: TabBarView(
              children:<Widget>[
                empresaDados(),
                empresaPlano()
              ]
              ),
          ))
    );
     
      
  }


  Widget empresaDados(){

  TextEditingController cpnjController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController dtcadastroController = TextEditingController();
  TextEditingController inicioUzoController = TextEditingController();
  TextEditingController enderecotroController = TextEditingController();
  
    TextEditingController tipo = TextEditingController();
  TextEditingController atendimento = TextEditingController();
  TextEditingController situacao = TextEditingController();

   
   tipo.text =  empresa.tipo!.toLowerCase();
   atendimento.text =  empresa.tipoAtendimento!.toLowerCase();
   situacao.text =  empresa.ativo == true ? 'Ativo' : 'Inativo';
    nomeController.text =  empresa.nome!;
    emailController.text = empresa.email == null ? "" : empresa.email!;
    telefoneController.text = empresa.telefone == null ? "" : empresa.telefone!;
    cpnjController.text = empresa.cnpjCpf == null ? "" : empresa.cnpjCpf!;
    dtcadastroController.text = getFormatedDate(empresa.cadastro);
    inicioUzoController.text = getFormatedDate(empresa.inicioUtilizacaoApp);
    enderecotroController.text =
        empresa.displayEndereco == null ? "" : empresa.displayEndereco!;

    return   Padding(
         padding: EdgeInsets.only(left: 10),
        child: Center(
          child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // _buildIcon(80, 80),
                    SizedBox(height: 20),

                    Container(
                      height: 50,
                     
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                           SizedBox(height: 15),
                          Flexible(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.only( bottom: 10),
                              height: 50,
                              child: TextField(
                                  style: TextStyle(overflow: TextOverflow.fade),
                                enabled: false,
                                controller: dtcadastroController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Cadastro',
                                    labelStyle: TextStyle(fontSize: 15)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10),
                              height: 50,
                              child: TextField(
                                  style: TextStyle(overflow: TextOverflow.fade),
                                enabled: false,
                                controller: inicioUzoController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Início do uso',
                                    labelStyle: TextStyle(fontSize: 15)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Flexible(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only( bottom: 10),
                        child: TextField(
                          enabled: false,
                          controller: nomeController,
                          maxLines: 3,
                          minLines: 1,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nome',
                              labelStyle: TextStyle(fontSize: 15)),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 50,
                     
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                           SizedBox(height: 15),
                          Flexible(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.only( bottom: 10),
                              height: 50,
                              child: TextField(
                                  style: TextStyle(overflow: TextOverflow.fade),
                                enabled: false,
                                controller: tipo,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Tipo',
                                    labelStyle: TextStyle(fontSize: 15)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.only( bottom: 10),
                              height: 50,
                              child: TextField(
                                  style: TextStyle(overflow: TextOverflow.fade),
                                enabled: false,
                                controller: atendimento,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Atendimento',
                                    labelStyle: TextStyle(fontSize: 15)),
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                    SizedBox(height: 5),


                    Container(
                      height: 50,
                      padding: EdgeInsets.only( bottom: 10),
                      child: TextField(
                        enabled: false,
                        controller: cpnjController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: empresa.cnpjCpf.toString().contains('/') ?
                             'CNPJ' : 'CPF',
                            labelStyle: TextStyle(fontSize: 15)),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only( bottom: 10),
                      child: TextField(
                        enabled: false,
                        controller: emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            labelStyle: TextStyle(fontSize: 15)),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only( bottom: 10),
                      child: TextField(
                        enabled: false,
                        controller: telefoneController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Telefone',
                            labelStyle: TextStyle(fontSize: 15)),
                      ),
                    ),
                   SizedBox(height: 5),
                    Container(
                      height: 120,
                      padding: EdgeInsets.only( bottom: 10, top: 10),
                      child: TextField(
                        maxLines: 3,
                        enabled: false,
                        controller: enderecotroController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Endereço',
                            labelStyle: TextStyle(fontSize: 15)),
                      ),
                    ),
                  ],
                ),
        ),
      );
    
        
        
  }

  Widget empresaPlano(){

  TextEditingController descricao = TextEditingController();
  TextEditingController itens = TextEditingController();
  TextEditingController profi = TextEditingController();
  TextEditingController fotos = TextEditingController();
  TextEditingController valor = TextEditingController();
  TextEditingController desconto = TextEditingController();
  TextEditingController percetDesconto = TextEditingController();
  TextEditingController mesGratis = TextEditingController();
  TextEditingController plano = TextEditingController();
  
    descricao.text =  empresa.plano!.descricao!;
    itens.text = empresa.plano!.itensCatalogo.toString();
    profi.text = empresa.plano!.profissionais.toString();
    fotos.text = empresa.plano!.fotosServico.toString();
    valor.text = empresa.plano!.valor.toString();
    desconto.text = empresa.plano!.desconto.toString();
    percetDesconto.text = empresa.plano!.percentualServico.toString();
    mesGratis.text = empresa.plano!.mesesGratis.toString();
     plano.text = empresa.plano!.emptyPlano! == true ? 'Nenhum': 'Plano ativo' ;

    return Padding(
        padding: const EdgeInsets.only(left: 10),
     
        child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // _buildIcon(80, 80),
                    SizedBox(height: 20),

                
                    Flexible(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only( bottom: 10),
                        child: TextField(
                          enabled: false,
                          controller: descricao,
                          maxLines: 3,
                          minLines: 1,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Descrição',
                              labelStyle: TextStyle(fontSize: 15)),
                        ),
                      ),
                    ),

                     Container(
                      height: 50,
                     
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                           SizedBox(height: 15),
                          Flexible(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.only( bottom: 10),
                              height: 50,
                              child: TextField(
                                  style: TextStyle(overflow: TextOverflow.fade),
                                enabled: false,
                                controller: profi,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Profissionais',
                                    labelStyle: TextStyle(fontSize: 15)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10),
                              height: 50,
                              child: TextField(
                                  style: TextStyle(overflow: TextOverflow.fade),
                                enabled: false,
                                controller: itens,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Itens',
                                    labelStyle: TextStyle(fontSize: 15)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  


            Container(
                      height: 50,
                     
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                           SizedBox(height: 15),
                          Flexible(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.only( bottom: 10),
                              height: 50,
                              child: TextField(
                                  style: TextStyle(overflow: TextOverflow.fade),
                                enabled: false,
                                controller: percetDesconto,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: '% Serviço',
                                    labelStyle: TextStyle(fontSize: 15)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            flex: 4,
                            child: Container(
                              padding: EdgeInsets.only( bottom: 10),
                              height: 50,
                              child: TextField(
                                  style: TextStyle(overflow: TextOverflow.fade),
                                enabled: false,
                                controller: valor,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Valor',
                                    labelStyle: TextStyle(fontSize: 15)),
                              ),
                            ),
                          ),
                           SizedBox(
                            width: 2,
                          ),
                          Flexible(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.only( bottom: 10),
                              height: 50,
                              child: TextField(
                                  style: TextStyle(overflow: TextOverflow.fade),
                                enabled: false,
                                controller: desconto,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Desconto',
                                    labelStyle: TextStyle(fontSize: 15)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                     Container(
                      height: 50,
                     
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                           SizedBox(height: 15),
                          Flexible(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.only( bottom: 10),
                              height: 50,
                              child: TextField(
                                  style: TextStyle(overflow: TextOverflow.fade),
                                enabled: false,
                                controller: mesGratis,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Mês grátis',
                                    labelStyle: TextStyle(fontSize: 15)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.only( bottom: 10),
                              height: 50,
                              child: TextField(
                                  style: TextStyle(overflow: TextOverflow.fade),
                                enabled: false,
                                controller: plano,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Plano escolhido',
                                    labelStyle: TextStyle(fontSize: 15)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  


                  ],
                ),
      
    );
        
        
  }



}