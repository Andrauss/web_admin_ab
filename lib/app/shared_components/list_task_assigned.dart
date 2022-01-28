import 'package:agenda_beauty_online/app/constans/app_constants.dart';
import 'package:agenda_beauty_online/app/features/dashboard/views/components/tela_mobile.dart';
import 'package:agenda_beauty_online/app/features/dashboard/views/screens/dashboard_screen.dart';
import 'package:agenda_beauty_online/app/features/dashboard/views/screens/empresa_detail.dart';
import 'package:agenda_beauty_online/app/features/elements/progress_indicator.dart';
import 'package:agenda_beauty_online/app/model/EmpresaPesquisa.dart';
import 'package:agenda_beauty_online/app/model/PesquisaEmpresa.dart';
import 'package:agenda_beauty_online/app/shared_components/responsive_builder.dart';
import 'package:agenda_beauty_online/app/util/Utils.dart';
import 'package:agenda_beauty_online/app/utils/helpers/app_helpers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:timeago/timeago.dart' as timeago;

class ListTaskAssignedData {
  final Icon icon;
  final String label;
  final String jobDesk;
  final DateTime? editDate;
  final String? assignTo;

  const ListTaskAssignedData({
    required this.icon,
    required this.label,
    required this.jobDesk,
    this.editDate,
    this.assignTo,
  });
}

class ListTaskAssigned extends StatelessWidget {
  ListTaskAssigned({
    required this.data,
    required this.onPressed,
    required this.onPressedAssign,
    required this.onPressedMember,
    Key? key,
  }) : super(key: key);

  final PesquisaEmpresa data;
  final Function() onPressed;
  final Function()? onPressedAssign;
  final Function()? onPressedMember;

  TextEditingController cpnjController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController dtcadastroController = TextEditingController();
  TextEditingController inicioUzoController = TextEditingController();
  TextEditingController enderecotroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        print('empresa clicada');
        print(data.toJson());
        
        
        if(  (ResponsiveBuilder.isMobile(Get.context!) ) ){
           
            Get.to( TelaMobile(tela: 'Empresa',body: EmpresaDetail(empresa: data)));

        }else{
            var dashController = Get.put(DashboardController());
            dashController.pesquisaEmpresa.value = data;
            dashController.empresaDetailVisible.value = true;
         
        }
       
 
      },
      hoverColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      leading: _buildIcon(50, 50),
      title: _buildTitle(),
      subtitle: _buildSubtitle(),
      trailing: _buildAssign(),
    );
  }

  showFoto(PesquisaEmpresa empresa) {
    return Get.dialog(AlertDialog(
      content: Container(
          height: Get.height,
          width: Get.width,
          child: CachedNetworkImage(
            imageUrl: empresa.fotoPerfil!,
            placeholder: (context, url) => AgendaBeautyProgressIndicator(),
            errorWidget: (context, url, error) => Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          )),
      actions: [
        RaisedButton(
          child: Text('Fechar'),
          onPressed: () => Get.back(result: true),
          // ** result: returns this value up the call stack **
        ),
      ],
    ));
  }

  showEmpresa(PesquisaEmpresa empresa) {
    nomeController.text = empresa.nome!;
    emailController.text = empresa.email == null ? "" : empresa.email!;
    telefoneController.text = empresa.telefone == null ? "" : empresa.telefone!;
    cpnjController.text = empresa.cnpjCpf == null ? "" : empresa.cnpjCpf!;
    dtcadastroController.text = getFormatedDate(empresa.cadastro);
    inicioUzoController.text = getFormatedDate(empresa.inicioUtilizacaoApp);
    enderecotroController.text =
        empresa.displayEndereco == null ? "" : empresa.displayEndereco!;
    return Get.dialog(AlertDialog(
      title: Text(
        'Dados da empresa',
        textAlign: TextAlign.center,
      ),
      content: Container(
        height: 480,
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // _buildIcon(80, 80),
            // SizedBox(height: 15),

            Container(
              height: 50,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.only(left: 5, right: 1, bottom: 10),
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
                      padding: EdgeInsets.only(left: 1, right: 5, bottom: 10),
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
            Flexible(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                child: TextField(
                  enabled: false,
                  controller: nomeController,
                  maxLines: 3,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome',
                      labelStyle: TextStyle(fontSize: 15)),
                ),
              ),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
              child: TextField(
                enabled: false,
                controller: cpnjController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: data.cnpjCpf.toString().contains('/') ?
                     'CNPJ' : 'CPF',
                    labelStyle: TextStyle(fontSize: 15)),
              ),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
              child: TextField(
                enabled: false,
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 15)),
              ),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
              child: TextField(
                enabled: false,
                controller: telefoneController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Telefone',
                    labelStyle: TextStyle(fontSize: 15)),
              ),
            ),
            Container(
              height: 120,
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 10),
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
      actions: [
        RaisedButton(
          child: Text('Fechar'),
          onPressed: () => Get.back(result: true),
          // ** result: returns this value up the call stack **
        ),
      ],
    ));
  }

  Widget _buildIcon(double heighT, double widthT) {
    return Container(
        height: heighT,
        width: widthT,
        child: InkWell(
          onTap: () {
            showFoto(data);
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            margin: EdgeInsets.all(0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: data.fotoPerfil == null
                    ? Container(
                        decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: CachedNetworkImageProvider(
                            "assets/images/image_default.png",
                            scale: 50,
                          ),
                        ),
                      ))
                    : _buildUrlImage(data.fotoPerfil!)),
          ),
        ));
  }

  _buildUrlImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => AgendaBeautyProgressIndicator(),
      errorWidget: (context, url, error) => Icon(
        Icons.cancel,
        color: Colors.red,
      ),
    );
  }

  Widget _buildIconOld() {
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.blueGrey.withOpacity(.1),
        ),
        child: Container(
          child: Image.network(data.fotoPerfil.toString()),
        ));
  }

  Widget _buildTitle() {
    return Text(
      data.nome.toString(),
      style: const TextStyle(fontWeight: FontWeight.bold),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle() {
    String edit = "";

    // if (data.editDate != null) {
    //   edit = " \u2022 edited ${timeago.format(data.editDate!)}";
    // }

    return Text(
      data.bloqueio!
          ? 'Bloqueado em ${convertData(data.bloqueioData!)}'
          : 'Ativo',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  String convertData(List data) {
    var retorno = "--/--/--";

    try {
      print('convertData');
      print(data);
      var datas =
          DateTime(data[0], data[1], data[2], data[3], data[4], data[5]);
      final date = new DateFormat('dd-MM-yy');
      final time = new DateFormat('hh:mm');

      retorno = date.format(datas) + ' ás ' + time.format(datas);
    } catch (e) {}

    return retorno;
  }

  getFormatedDate(_date) {
    if (_date == null) {
      return "";
    }
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd/MM/yy');
    return outputFormat.format(inputDate);
  }

  Widget _buildAssign() {
    return (data.bloqueio!)
        ? InkWell(
            onTap: onPressedMember,
            borderRadius: BorderRadius.circular(22),
            child: Tooltip(
              message: 'Bloqueado',
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.orange.withOpacity(.2),
                child: Text(
                  // data.assignTo!.getInitialName(2).toUpperCase(),
                  'Bloqueado',
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        : DottedBorder(
            color: kFontColorPallets[1],
            strokeWidth: .3,
            strokeCap: StrokeCap.round,
            borderType: BorderType.Circle,
            child: IconButton(
              onPressed: onPressedAssign,
              color: kFontColorPallets[1],
              iconSize: 15,
              icon: const Icon(EvaIcons.moreHorizontal),
              splashRadius: 24,
              tooltip: "Opções",
            ),
          );
  }
}
