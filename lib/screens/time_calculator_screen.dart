import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kalculator/models/history.dart';

class TimeCalculatorScreen extends StatefulWidget {
  @override
  _TimeCalculatorScreenState createState() => _TimeCalculatorScreenState();
}


class _TimeCalculatorScreenState extends State<TimeCalculatorScreen> {
  int totalMonths = 0;
  int totalYears = 0;
  TextEditingController monthsController = TextEditingController();
  TextEditingController yearsController = TextEditingController();
  List<HistoryEntry> history = []; // Lista para armazenar o histórico

  // void addTime() {
  //   // Código de adicionar o tempo (mantido igual)
  //   int addedYears = int.parse(yearsController.text) ?? 0;
  //   int addedMonths = int.parse(monthsController.text) ?? 0;
  //
  //   // Atualizar a tela
  //   setState(() {
  //     totalYears += addedYears;
  //     totalMonths += addedMonths;
  //     history.add(HistoryEntry(addedYears, addedMonths));
  //   });
  // }
  void addTime() {
    int months = int.tryParse(monthsController.text) ?? 0;
    int years = int.tryParse(yearsController.text) ?? 0;

    setState(() {
      totalMonths += months;
      totalYears += years;
      totalYears += (totalMonths ~/ 12); // Update total years
      totalMonths %= 12; // Keep months within 0-11 range
      history.add(HistoryEntry(years, months, 'Agravante'));
      monthsController.clear();
      yearsController.clear();
    });
  }

  // void subtractTime() {
  //   // Código de subtrair o tempo (mantido igual)
  //   int subtractedYears = int.parse(yearsController.text) ?? 0;
  //   int subtractedMonths = int.parse(monthsController.text) ?? 0;
  //
  //   // Atualizar a tela
  //   setState(() {
  //     totalYears -= subtractedYears;
  //     totalMonths -= subtractedMonths;
  //     history.add(HistoryEntry(-subtractedYears, -subtractedMonths));
  //     // Handle negative months
  //     while (totalMonths < 0) {
  //       totalMonths += 12;
  //       totalYears--;
  //     }
  //     monthsController.clear();
  //     yearsController.clear();
  //   });
  // }
  void subtractTime() {
    int months = int.tryParse(monthsController.text) ?? 0;
    int years = int.tryParse(yearsController.text) ?? 0;

    setState(() {
      totalMonths -= months;
      totalYears -= years;
      history.add(HistoryEntry(-years, -months, 'Atenuante'));
      // Handle negative months
      while (totalMonths < 0) {
        totalMonths += 12;
        totalYears--;
      }

      // Handle negative years
      //totalYears = totalYears.clamp(0, double.infinity.toInt());
      // if(totalYears < 0){
      //   totalYears = 0;
      // }else if(tot alYears > 500){
      //   totalYears = double.infinity.toInt();
      // }

      monthsController.clear();
      yearsController.clear();
    });
  }

  void clearTime() {
    // Código de zerar o tempo (mantido igual)
    totalMonths = 0;
    totalYears = 0;
    history.clear();
    // Atualizar a tela
    setState(() {
      // Atualize o estado da tela aqui
    });
  }

  void _openPrivacyPolicy() async {
    const url = 'https://github.com/Rigobertto'; // Substitua pelo URL correto
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir o URL: $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Tempo'),
        backgroundColor: Colors.green, // Cor verde para o AppBar
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'history') {
                _showHistoryDialog();
              }
            },
            itemBuilder: (BuildContext context) {
              return ['history'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text('Histórico'),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.transparent, // Cor verde para o CircleAvatar
                  //child: Image.network('https://agendamento.defensoria.rn.def.br/assets/logo-1a33c22bc3d059e0baf9a70ef5cd0f4be1c1277b0c6cc7db7a7a731d89f0d7a9.png'),
                ),
              ),
            ),



            SizedBox(height: 150),

            Text(
              'Total:',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              '$totalYears anos e $totalMonths meses',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: yearsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Anos'),
                  ),
                ),
                SizedBox(width: 16),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: monthsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Meses'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: addTime,
                  child: Text('Adicionar'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Cor verde para o botão
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: subtractTime,
                  child: Text('Subtrair'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Cor verde para o botão
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: clearTime,
                  child: Text('Zerar'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Cor verde para o botão
                  ),
                ),
              ],
            ),
            SizedBox(height: 200),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children: [
                    Text(
                      'Todos os Direitos Reservados - 2023',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: _openPrivacyPolicy,
                      child: Text(
                        'GitHub da Aplicação',
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    ),

                  ],

                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showHistoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Histórico'),

          content: SingleChildScrollView(
            child: Column(
              children: [
                for (var entry in history)
                  Text('${entry.years} anos ${entry.months} meses (${entry.actionType})'),
              ],

            ),

          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}

