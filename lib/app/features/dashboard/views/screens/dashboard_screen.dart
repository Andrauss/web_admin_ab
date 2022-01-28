library dashboard;

import 'package:agenda_beauty_online/app/constans/app_constants.dart';
import 'package:agenda_beauty_online/app/features/elements/ABProgressIndicator.dart';
import 'package:agenda_beauty_online/app/features/elements/progress_indicator.dart';
import 'package:agenda_beauty_online/app/model/EmpresaPesquisa.dart';
import 'package:agenda_beauty_online/app/model/PageModel.dart';
import 'package:agenda_beauty_online/app/model/PesquisaEmpresa.dart';
import 'package:agenda_beauty_online/app/model/empresa_perfil/EmpresaPerfil.dart';
import 'package:agenda_beauty_online/app/repository/empresa_perfil.dart';
import 'package:agenda_beauty_online/app/shared_components/card_task.dart';
import 'package:agenda_beauty_online/app/shared_components/header_text.dart';
import 'package:agenda_beauty_online/app/shared_components/list_task_assigned.dart';
import 'package:agenda_beauty_online/app/shared_components/list_task_date.dart';
import 'package:agenda_beauty_online/app/shared_components/responsive_builder.dart';
import 'package:agenda_beauty_online/app/shared_components/search_field.dart';
import 'package:agenda_beauty_online/app/shared_components/selection_button.dart';
import 'package:agenda_beauty_online/app/shared_components/simple_selection_button.dart';
import 'package:agenda_beauty_online/app/shared_components/simple_user_profile.dart';
import 'package:agenda_beauty_online/app/shared_components/task_progress.dart';
import 'package:agenda_beauty_online/app/shared_components/user_profile.dart';
import 'package:agenda_beauty_online/app/ui/agenda_beauty_buttons.dart';
import 'package:agenda_beauty_online/app/ui/error_panel.dart';
import 'package:agenda_beauty_online/app/util/Utils.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agenda_beauty_online/app/utils/helpers/app_helpers.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mdi/mdi.dart';

import 'empresa_detail.dart';

// binding
part '../../bindings/dashboard_binding.dart';

// controller
part '../../controllers/dashboard_controller.dart';

// model

// component
part '../components/bottom_navbar.dart';
part '../components/header_weekly_task.dart';
part '../components/main_menu.dart';
part '../components/task_menu.dart';
part '../components/member.dart';
part '../components/task_in_progress.dart';
part '../components/weekly_task.dart';
part '../components/task_group.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scafoldKey,
      drawer: ResponsiveBuilder.isDesktop(context)
          ? null
          : Drawer(
              child: SafeArea(
                child: SingleChildScrollView(child: _buildSidebar(context)),
              ),
            ),
      bottomNavigationBar: (ResponsiveBuilder.isDesktop(context) || kIsWeb)
          ? null
          : const _BottomNavbar(),
      body: SafeArea(
        child: ResponsiveBuilder(
          mobileBuilder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTaskContent(
                    onPressedMenu: () => controller.openDrawer(),
                  ),
                  // _buildCalendarContent(),
                ],
              ),
            );
          },
          tabletBuilder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: constraints.maxWidth > 800 ? 8 : 7,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: _buildTaskContent(
                      onPressedMenu: () => controller.openDrawer(),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const VerticalDivider(),
                ),
                Obx(()=>Flexible(
                  flex: 5,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    
                    child: controller.empresaDetailVisible.value == true ?
                    _buildEmpresaContent() :
                    _buildCalendarContent(),
                  ),
                )),
              ],
            );
          },
          desktopBuilder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: constraints.maxWidth > 1350 ? 3 : 4,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: _buildSidebar(context),
                  ),
                ),
                Flexible(
                  flex: constraints.maxWidth > 1350 ? 10 : 9,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: _buildTaskContent(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const VerticalDivider(),
                ),
                Obx(()=>Flexible(
                  flex: 5,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: controller.empresaDetailVisible.value == true ?
                    _buildEmpresaContent() :
                    _buildCalendarContent(),
                  )),
                ),
                
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: UserProfile(
            data: controller.dataProfil,
            onPressed: controller.onPressedProfil,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _MainMenu(onSelected: controller.onSelectedMainMenu),
        ),
        const Divider(
          indent: 20,
          thickness: 1,
          endIndent: 20,
          height: 60,
        ),
        // _Member(member: controller.member),
        // const SizedBox(height: kSpacing),
        // _TaskMenu(
        //   onSelected: controller.onSelectedTaskMenu,
        // ),
        const SizedBox(height: kSpacing),
        Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: Text(
            "2022 ReinvetApps",
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskContent({Function()? onPressedMenu}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        children: [
          const SizedBox(height: kSpacing),
          Row(
            children: [
              if (onPressedMenu != null)
                Padding(
                  padding: const EdgeInsets.only(right: kSpacing / 2),
                  child: IconButton(
                    onPressed: onPressedMenu,
                    icon: const Icon(Icons.menu),
                  ),
                ),
            ],
          ),
          // const SizedBox(height: kSpacing),
          // Row(
          //   children: [
          //     Expanded(
          //       child: HeaderText(
          //         DateTime.now().formatDDMMYYYY(),
          //       ),
          //     ),
          //     const SizedBox(width: kSpacing / 2),
          //     // SizedBox(
          //     //   width: 200,
          //     //   child: TaskProgress(data: controller.dataTask),
          //     // ),
          //   ],
          // ),
          // const SizedBox(height: kSpacing),
          // _TaskInProgress(data: controller.taskInProgress),
          const SizedBox(height: kSpacing * 2),
          _HeaderWeeklyTask(),
          Obx(() => Visibility(
              visible: controller.listEmpresasPesquisaFull.value.length >= 6,
              child: SearchField())),
          const SizedBox(height: kSpacing),
          Obx(() => _WeeklyTask(
                data: controller.listEmpresasPesquisa.value,
                onPressed: controller.onPressedTask,
                onPressedAssign: controller.onPressedAssignTask,
                onPressedMember: controller.onPressedMemberTask,
              ))
        ],
      ),
    );
  }

  Widget _buildCalendarContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        children: [
          const SizedBox(height: kSpacing),
          Row(
            children: [
              const Expanded(child: HeaderText("Calendar")),
              IconButton(
                onPressed: controller.onPressedCalendar,
                icon: const Icon(EvaIcons.calendarOutline),
                tooltip: "calendar",
              )
            ],
          ),
          const SizedBox(height: kSpacing),
          // ...controller.taskGroup
          //     .map(
          //       (e) => _TaskGroup(
          //         title: DateFormat('d MMMM').format(e[0].date),
          //         data: e,
          //         onPressed: controller.onPressedTaskGroup,
          //       ),
          //     )
          //     .toList()
        ],
      ),
    );
  }

 Widget _buildEmpresaContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        children: [
          const SizedBox(height: kSpacing),
          Row(
            children: [
              const Expanded(child: HeaderText("Empresa detalhe")),
              IconButton(
                onPressed: () => controller.empresaDetailVisible.value = false,
                icon: const Icon(EvaIcons.close),
                tooltip: "Fechar",
              )
            ],
          ),
          // const SizedBox(height: kSpacing),
          EmpresaDetail(empresa: controller.pesquisaEmpresa.value)
          // ...controller.taskGroup
          //     .map(
          //       (e) => _TaskGroup(
          //         title: DateFormat('d MMMM').format(e[0].date),
          //         data: e,
          //         onPressed: controller.onPressedTaskGroup,
          //       ),
          //     )
          //     .toList()
        ],
      ),
    );
  }



}
