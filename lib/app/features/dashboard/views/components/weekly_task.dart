part of dashboard;

class _WeeklyTask extends StatelessWidget {
  _WeeklyTask({
    required this.data,
    required this.onPressed,
    required this.onPressedAssign,
    required this.onPressedMember,
    Key? key,
  }) : super(key: key);

  final List<PesquisaEmpresa> data;
  final Function(int index, PesquisaEmpresa data) onPressed;
  final Function(int index, PesquisaEmpresa data) onPressedAssign;
  final Function(int index, PesquisaEmpresa data) onPressedMember;

  ScrollController _scrollController = new ScrollController();
  bool _searchMode = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 500,
      child: _body(),
    );
  }

  Future<Null> _refresh() async {
    var dashController = Get.put(DashboardController());
    dashController.currentPage.value++;
    dashController.getEmpresaPesquisa(dashController.search.value);
    return Future.delayed(Duration(microseconds: 300), () {});
  }

  _body() {
    return SafeArea(
      child: RefreshIndicator(
          onRefresh: _refresh,
          child: Center(child: Obx(() => _buildListview()))),
    );
  }

  _buildLoading() {
    return Center(
        child: Container(
      height: 50,
      alignment: AlignmentDirectional.center,
      child: AgendaBeautyProgressIndicator(),
    ));
  }

  Widget _buildPreviousPage() {
    var dashController = Get.put(DashboardController());

    return dashController.currentPage.value != 0
        ? FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () {
              loadDadosPage(dashController.currentPage.value - 1);
            },
            child: Row(
              children: [
                Icon(
                  EvaIcons.arrowIosBack,
                  size: 16,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Anterior"),
              ],
            ),
          )
        : FlatButton(
            onPressed: () {},
            child: Text(''),
          );
  }

  Widget _buildNextPage() {
    var dashController = Get.put(DashboardController());

    return dashController.pageModel.value.last!
        ? FlatButton(
            onPressed: () {},
            child: Text(''),
          )
        : FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () {
              loadDadosPage(dashController.currentPage.value == 0
                  ? 1
                  : dashController.currentPage.value + 1);
            },
            child: Row(
              children: [
                Text("Próximo"),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  EvaIcons.arrowIosForward,
                  size: 16,
                ),
              ],
            ),
          );
  }

  _buildListview() {
    var dashController = Get.put(DashboardController());

    if (dashController.firstSearch.value == true) {
      return _buildFirst();
    }

    if (dashController.isLoading.value == true) {
      return AgendaBeautyProgressIndicator();
    }

    if (dashController.error.value == true) {
      return _buildError();
    }
    if (dashController.empty.value == true) {
      return _buildEmpty();
    }

    return Column(
      children: [
        Obx(() => Visibility(
              visible: dashController.pageModel.value.totalPages! > 1 &&
                  dashController.isLoading.value == false,
              child: Container(
                height: 50,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPreviousPage(),
                        Center(
                          child: Obx(() => Text(
                              'Lista ${dashController.pageModel.value.last! ? dashController.pageModel.value.totalPages : dashController.currentPage.value + 1} de ${dashController.pageModel.value.totalPages}')),
                        ),
                        _buildNextPage()
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: Get.width - 100,
                      color: Colors.black26,
                      height: 1,
                    )
                  ],
                ),
              ),
            )),
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.only(top: 16, bottom: 70),
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                // if (index == data.length) {
                //   return AnimatedSwitcher(
                //     duration: Duration(milliseconds: 250),
                //     child: (dashController.pageModel == null || !dashController.pageModel.value.last!)
                //         ? !dashController.error.value
                //             ? Container(
                //                 height: 50,
                //                 alignment: AlignmentDirectional.center,
                //                 child: AgendaBeautyProgressIndicator(),
                //               )
                //             : Container(
                //                 color: Colors.red[200],
                //                 child: ListTile(
                //                   dense: true,
                //                   onTap: () {
                //                     // _loadClientes();
                //                   },
                //                   leading: Icon(EvaIcons.alertTriangleOutline),
                //                   title: Text(
                //                     "Falha ao carregar clientes",
                //                     style: TextStyle(fontSize: 12),
                //                   ),
                //                   trailing: IconButton(
                //                     icon: Icon(Icons.refresh),
                //                     onPressed: () {
                //                       // _loadClientes();
                //                     },
                //                   ),
                //                 ),
                //               )
                //         : SizedBox(
                //             height: 0,
                //           ),
                //   );
                // }

                final cliente = data[index];
                return ListTaskAssigned(
                  data: cliente,
                  onPressed: () => onPressed(index, cliente),
                  onPressedAssign: () => onPressedAssign(index, cliente),
                  onPressedMember: () => onPressedMember(index, cliente),
                );
              }),
        ),
      ],
    );
  }

  void _checkScroll() {
    var dashController = Get.put(DashboardController());
    if (_scrollController.position.pixels >=
        (_scrollController.position.maxScrollExtent - 80)) {
      if ((dashController.pageModel == null ||
              !dashController.pageModel.value.last!) &&
          !dashController.error.value) {
        print("_pageModel.last: ${dashController.pageModel.value.last!}");
        dashController.currentPage++;
        // _loadClientes();
      }
    }
  }

  _buildFirst() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.6),
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(150)),
            ),
            child: Opacity(
              opacity: 0.6,
              child: Icon(
                Icons.search,
                size: 60,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(18.0),
          child: Text(
            "Pesquise na opção: Filtro",
            style: TextStyle(color: Colors.grey.withOpacity(0.6), fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  _buildEmpty() {
    var dashController = Get.put(DashboardController());
    return _searchMode && dashController.search.value == null
        ? Container()
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.6),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(150)),
                  ),
                  child: Opacity(
                    opacity: 0.6,
                    child: Icon(
                      _searchMode ? Icons.search : Mdi.accountGroupOutline,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  _searchMode
                      ? 'Nenhuma empresa encontrada'
                      : "Nenhuma empresa encontrada",
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.6), fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              Visibility(
                visible: _searchMode,
                child: Opacity(
                  opacity: 0.6,
                  child: Container(
                    width: 200,
                    child:
                        AgendaBeautyButtons.Outlined("Pesquisar novamente", () {
                      loadDados();
                    }, round: true),
                  ),
                ),
              ),
              Visibility(
                visible: _searchMode,
                child: Opacity(
                  opacity: 0.6,
                  child: Container(
                    width: 200,
                    child: AgendaBeautyButtons.Outlined("Listar todos", () {
                      // _exitSearchMode();
                      loadDados();

                    }, round: true),
                  ),
                ),
              )
            ],
          );
  }

  _buildError() {
    return ErrorPanel(
      'Falha ao carregar!',
      opacity: 0,
      icon: Icon(Mdi.alert),
      actions: <Widget>[
        ErrorPanel.ErrorIconButton(
          'Tentar novamente',
          Icon(Icons.refresh),
          () {
            loadDados();
          },
        )
      ],
    );
  }


  loadDados() async {
    var dashController = Get.put(DashboardController());
    dashController.currentPage.value = 0;
    dashController.listEmpresasPesquisa.value = [];
    dashController.getEmpresaPesquisaMore();
  }

  loadDadosPage(int page) async {
    print('loadDadosPage page: $page');
    var dashController = Get.put(DashboardController());
    dashController.currentPage.value = page;
    dashController.listEmpresasPesquisa.value = [];
    dashController.getEmpresaPesquisaMore();
  }
}
