import 'package:financas/src/class/Movimentacoes.dart';
import 'package:financas/src/components/DialogRD.dart';
import 'package:financas/src/data/MovRepository.dart';
import 'package:financas/src/screens/home_screen.dart';
import 'package:financas/src/screens/lancamentos_screen.dart';
import 'package:financas/src/screens/metas_screen.dart';
import 'package:financas/src/screens/relatorios_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selecionarIndex = 0;
  final List<Map<String, Object>> _screens = [
    {'title': 'Organize', 'screen': HomeScreen()},
    {'title': 'Lançamentos', 'screen': LancamentosScreen()},
    //{'title': 'Ações', 'screen': AcoesScreen()},
    {'title': 'Relatórios', 'screen': RelatoriosScreen()},
    {'title': 'Metas', 'screen': MetasScreen()},
  ];

  final formatter = DateFormat('dd-MM-yyyy');
  final MovRepository repository = MovRepository();

  Color _colorContainer = Colors.greenAccent[400];
  Color _colorTextButtom = Colors.green;

  _dialogAddRecDesp() {
    //Movimentacoes mov = Movimentacoes();
    double width = MediaQuery.of(context).size.width;
    DialogRD addMov = DialogRD();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width * 0.050),
            ),
            title: Text(
              "Adicionar Valores",
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            backgroundColor: _colorContainer,
            content: addMov,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: width * 0.09),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Container(
                          padding: EdgeInsets.only(
                            top: width * 0.02,
                            bottom: width * 0.02,
                            left: width * 0.03,
                            right: width * 0.03,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              "Confirmar",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: _colorTextButtom,
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.05,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Movimentacoes novaMov = Movimentacoes(
                            valor: addMov.valor,
                            descricao: addMov.descricao,
                            data: addMov.data,
                            tipo: addMov.tipo,
                          );
                          repository.addMov(novaMov);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  _selecionar(int index) {
    setState(() {
      _selecionarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: "Adicionar finanças",
          onPressed: () {
            _dialogAddRecDesp();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.greenAccent[400],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: _screens[_selecionarIndex]['screen'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selecionar,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.greenAccent[400],
          currentIndex: _selecionarIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Início'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows),
              title: Text('Lançamentos'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.equalizer),
              title: Text('Relatórios'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.track_changes),
              title: Text('Metas'),
            ),
          ],
        ),
      ),
    );
  }
}
