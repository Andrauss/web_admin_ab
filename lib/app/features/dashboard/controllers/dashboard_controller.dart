part of dashboard;

class DashboardController extends GetxController {
  final scafoldKey = GlobalKey<ScaffoldState>();

  var listEmpresasPesquisa = List<PesquisaEmpresa>.empty(growable: true).obs;
  var listEmpresasPesquisaFull =
      List<PesquisaEmpresa>.empty(growable: true).obs;

  var listEmpresasPerfil = List<EmpresaPesquisa>.empty(growable: true).obs;

  var pesquisaEmpresa = PesquisaEmpresa().obs;
  var empresaDetailVisible = false.obs;

  var empresasByID = {}.obs;

  var isLoading = false.obs;

  var currentPage = 0.obs;

  var pageModel = PagedModel().obs;

  var error = false.obs;

  var search = "".obs;

  var searchMore = {}.obs;

  var empty = false.obs;

  var firstSearch = true.obs;

  @override
  void onInit() {
    super.onInit();
    // getEmpresas('weslley');
    // getEmpresaPesquisa('weslley');
  }

  void getEmpresas(String text) async {
    // print('listEmpresasPesquisa chamou função');

    try {
      isLoading(true);

      var dados = await EmpresaPerfilService().getEmpresaSearch(text);
      // listEmpresasPesquisa.assignAll(dados);
      // listEmpresasPesquisa.refresh();

      // print('listEmpresasPesquisa: ${listEmpresasPesquisa.length}');
      isLoading(false);
    } on Exception catch (e) {
      isLoading(false);
    }
  }

  void getEmpresaByIDBeauty(String text) async {
    // print('listEmpresasPesquisa chamou função');

    try {
      isLoading(true);

      var empresa = await EmpresaPerfilService().getEmpresaByidBeauty(text);
      print('getEmpresaByID');
      print(empresa);
      empresasByID = empresa as RxMap;

      // print('listEmpresasPesquisa: ${listEmpresasPesquisa.length}');
      isLoading(false);
    } on Exception catch (e) {
      isLoading(false);
    }
  }

  void getEmpresaByID(String text) async {
    // print('listEmpresasPesquisa chamou função');

    try {
      // isLoading(true);

      var empresa = await EmpresaPerfilService().getEmpresaPerfil(text);
      print('getEmpresaByID');
      print(empresa);
      // empresasByID = empresa as RxMap;

      // print('listEmpresasPesquisa: ${listEmpresasPesquisa.length}');
      // isLoading(false);
    } on Exception catch (e) {
      // isLoading(false);
    }
  }

  void searcEmpresaPesquisaByModel(dynamic dados) {
    currentPage.value = 0;
    listEmpresasPesquisa.value = [];
    search.value = dados['nome'];
    getEmpresaPesquisa(dados);
  }

  void searchByText(String text) async {
    print('searchByText: $text');

    listEmpresasPesquisa.value = [];
    if (text.isEmpty) {
  
      listEmpresasPesquisa = listEmpresasPesquisaFull;
      return;
    }

    listEmpresasPesquisa.value = listEmpresasPesquisaFull
        .where((element) =>
            (element.nome.toString().toLowerCase().contains(text.toLowerCase()) ||
            element.telefone
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase()) ||
            element.cnpjCpf
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase()) ||
            element.email
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase())
            ))
        .toList();
  }

  void getEmpresaPesquisa(dynamic text) async {
    print('listEmpresasPesquisa chamou função');
    print(text);
    

    try{
      searchMore.value = text;
    }catch(a){
      text = {'nome':'${text}'};
      // searchMore.value = text;
    }
  

     print(searchMore.value);

    // search.value = text;
    firstSearch.value = false;
    error.value = false;
    empty.value = false;
    isLoading.value = false;

    try {
      if (listEmpresasPesquisa.isNotEmpty) {
        if (pageModel.value.last!) {
          return;
        }
      }

      isLoading.value = true;

      var dados = await EmpresaPerfilService()
          .listPaged(search: text, page: currentPage.value, size: 10);
      print('getEmpresaPesquisa PageModel');
      print(dados.toJson());

      print('getEmpresaPesquisa empty: ${dados.empty}');

      empty.value = dados.empty!;
      isLoading(false);

      listEmpresasPesquisa.value = dados.content!;
      listEmpresasPesquisaFull.value = listEmpresasPesquisa.value;
      pageModel.value = dados;

      print('currentPage getEmpresaPesquisa: ${currentPage.value}');

      // print('listEmpresasPesquisa: ${listEmpresasPesquisa.length}');
      isLoading.value = false;
      error.value == false;
    } catch (e) {
      isLoading.value = false;
      error.value = true;
      print('getEmpresaPesquisa erro');
      print(e);

      // if( e.toString().contains('401')) {
      //   // Sleep(Duration(seconds: 2));
      //     getEmpresaPesquisa(searchMore.value);
      // }

    }
  }

  void getEmpresaPesquisaMore() async {
    print('listEmpresasPesquisa chamou função');


     print(searchMore.value);

    // search.value = text;
    firstSearch.value = false;
    error.value = false;
    empty.value = false;
    isLoading.value = false;

    try {
     
      isLoading.value = true;

      var dados = await EmpresaPerfilService()
          .listPaged(search: searchMore.value, page: currentPage.value, size: 10);
      print('getEmpresaPesquisa PageModel');
      print(dados.toJson());

      print('getEmpresaPesquisa empty: ${dados.empty}');

      empty.value = dados.empty!;
      isLoading(false);

      listEmpresasPesquisa.value = dados.content!;
      listEmpresasPesquisaFull.value = listEmpresasPesquisa.value;
      pageModel.value = dados;

      print('currentPage getEmpresaPesquisa: ${currentPage.value}');

      // print('listEmpresasPesquisa: ${listEmpresasPesquisa.length}');
      isLoading.value = false;
      error.value == false;
    } catch (e) {
      isLoading.value = false;
      error.value = true;
      print('getEmpresaPesquisa erro');
      print(e);

      // if( e.toString().contains('401')) {
      //   // Sleep(Duration(seconds: 2));
      //     getEmpresaPesquisa(searchMore.value);
      // }

    }
  }


  final dataProfil = const UserProfileData(
    image: AssetImage(ImageRasterPath.man),
    name: "Usuário",
    jobDesk: "Cargo",
  );

  final member = ["Avril Kimberly", "Michael Greg"];

  final dataTask = const TaskProgressData(totalTask: 5, totalCompleted: 1);

  final taskInProgress = [
    CardTaskData(
      label: "Determine meeting schedule",
      jobDesk: "System Analyst",
      dueDate: DateTime.now().add(const Duration(minutes: 50)),
    ),
    CardTaskData(
      label: "Personal branding",
      jobDesk: "Marketing",
      dueDate: DateTime.now().add(const Duration(hours: 4)),
    ),
    CardTaskData(
      label: "UI UX",
      jobDesk: "Design",
      dueDate: DateTime.now().add(const Duration(days: 2)),
    ),
    CardTaskData(
      label: "Determine meeting schedule",
      jobDesk: "System Analyst",
      dueDate: DateTime.now().add(const Duration(minutes: 50)),
    )
  ];

  final weeklyTask = [
    ListTaskAssignedData(
      icon: const Icon(EvaIcons.monitor, color: Colors.blueGrey),
      label: "Slicing UI",
      jobDesk: "Programmer",
      assignTo: "Alex Ferguso",
      editDate: DateTime.now().add(-const Duration(hours: 2)),
    ),
    ListTaskAssignedData(
      icon: const Icon(EvaIcons.star, color: Colors.amber),
      label: "Personal branding",
      jobDesk: "Marketing",
      assignTo: "Justin Beck",
      editDate: DateTime.now().add(-const Duration(days: 50)),
    ),
    const ListTaskAssignedData(
      icon: Icon(EvaIcons.colorPalette, color: Colors.blue),
      label: "UI UX ",
      jobDesk: "Design",
    ),
    const ListTaskAssignedData(
      icon: Icon(EvaIcons.pieChart, color: Colors.redAccent),
      label: "Determine meeting schedule ",
      jobDesk: "System Analyst",
    ),
  ];

  final taskGroup = [
    [
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 2, hours: 10)),
        label: "5 posts on instagram",
        jobdesk: "Marketing",
      ),
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 2, hours: 11)),
        label: "Platform Concept",
        jobdesk: "Animation",
      ),
    ],
    [
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 4, hours: 5)),
        label: "UI UX Marketplace",
        jobdesk: "Design",
      ),
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 4, hours: 6)),
        label: "Create Post For App",
        jobdesk: "Marketing",
      ),
    ],
    [
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 6, hours: 5)),
        label: "2 Posts on Facebook",
        jobdesk: "Marketing",
      ),
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 6, hours: 6)),
        label: "Create Icon App",
        jobdesk: "Design",
      ),
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 6, hours: 8)),
        label: "Fixing Error Payment",
        jobdesk: "Programmer",
      ),
      ListTaskDateData(
        date: DateTime.now().add(const Duration(days: 6, hours: 10)),
        label: "Create Form Interview",
        jobdesk: "System Analyst",
      ),
    ]
  ];

  void onSelectedMainMenu(int index, SelectionButtonData value) {}
  void onSelectedTaskMenu(int index, String label) {}

  void onPressedProfil() {
    print('onPressedProfil');
  }

  void searchTask(String value) {}

  void onPressedTask(int index, PesquisaEmpresa data) {
    print('onPressedTask empresa item da lista');
    print(data.toJson());
    // getEmpresaByID(data.id!);
  }

  void onPressedAssignTask(int index, PesquisaEmpresa data) {}
  void onPressedMemberTask(int index, PesquisaEmpresa data) {}
  void onPressedCalendar() {}
  void onPressedTaskGroup(int index, PesquisaEmpresa data) {}

  void openDrawer() {
    if (scafoldKey.currentState != null) {
      scafoldKey.currentState!.openDrawer();
    }
  }
}
