part of dashboard;

class _MainMenu extends StatelessWidget {
  const _MainMenu({
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  final Function(int index, SelectionButtonData value) onSelected;

  @override
  Widget build(BuildContext context) {
    return SelectionButton(
      data: [
        SelectionButtonData(
          activeIcon: EvaIcons.home,
          icon: EvaIcons.homeOutline,
          label: "Home",
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.bell,
          icon: EvaIcons.fileTextOutline,
          label: "Empresas",
          totalNotif: 100,
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.checkmarkCircle2,
          icon: EvaIcons.people,
          label: "Usuários",
          totalNotif: 5,
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.settings,
          icon: EvaIcons.settingsOutline,
          label: "Configurações",
        ),
      ],
      onSelected: onSelected,
    );
  }
}
