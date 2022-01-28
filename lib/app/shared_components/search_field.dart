import 'package:agenda_beauty_online/app/constans/app_constants.dart';
import 'package:agenda_beauty_online/app/features/dashboard/views/screens/dashboard_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class SearchField extends StatelessWidget {
  SearchField({
    this.onSearch,
    this.hintText,
    Key? key,
  }) : super(key: key);

  final controller = TextEditingController();
  final Function(String value)? onSearch;
  final String? hintText;
  RxBool ativo = false.obs;
  

  @override
  Widget build(BuildContext context) {
    return  Obx(()=>TextField(
      textInputAction: TextInputAction.go,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: ativo.value == false ? 
        Icon(EvaIcons.search) :
        InkWell(
          onTap: (){
            controller.clear();
            searc();
          },
          child: Icon(EvaIcons.closeCircle,color: Colors.orangeAccent,) 
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: .1),
        ),
        hintText: hintText ?? "Pequise pelo nome, telefone ou cpf",
      ),
      onChanged: (a){
        
         if(a.isNotEmpty){
            ativo.value = true;
           if(a.toString().length >=3 ){
              searc();
           }
         }else{
           
             searc();
           }
      },
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // print('onSearch: ${controller.text}');
        print('onSearch onEditingComplete');
        searc();
      },
      style: TextStyle(color: kFontColorPallets[1]),
      onSubmitted: (a) {
        print('onSearch onSubmitted');
        FocusScope.of(context).unfocus();
        searc();
      },
      // onTap: () {
      //   print('onSearch onTap');
      //   FocusScope.of(context).unfocus();
      //   if (controller.text.isNotEmpty) searc();
      // },
    )
     );
      }

  void searc() {
    print('Pesquisa search');
    print(controller.text);
    var dashController = Get.put(DashboardController());
    if(controller.text.trim().toString().isEmpty){
      ativo.value = false;
      dashController.listEmpresasPesquisa.value = dashController.listEmpresasPesquisaFull.value;
    }else{
      dashController.searchByText(controller.text);
    }
  }
}
