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
  int totalDays = 0;
  TextEditingController monthsController = TextEditingController();
  TextEditingController yearsController = TextEditingController();
  TextEditingController daysController = TextEditingController();

  List<HistoryEntry> history = []; // Lista para armazenar o histórico

  void addTime() {
    int months = int.tryParse(monthsController.text) ?? 0;
    int years = int.tryParse(yearsController.text) ?? 0;
    int days = int.tryParse(daysController.text) ?? 0;


    setState(() {
      totalMonths += months;
      totalYears += years;
      totalDays += days;

      // Converter dias em meses se necessário
      totalMonths += (totalDays ~/ 30);
      totalDays %= 30;

      totalYears += (totalMonths ~/ 12); // atualiza total years
      totalMonths %= 12;

      history.add(HistoryEntry(years, months, days, 'Agravante'));

      daysController.clear();
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
    int days = int.tryParse(daysController.text) ?? 0;


    setState(() {
      totalMonths -= months;
      totalYears -= years;
      totalDays -= days;

      // Converter dias em meses se necessário
      while (totalDays < 0) {
        totalDays += 30;
        totalMonths--;
      }

      // converter anos pra meses
      while (totalMonths < 0) {
        totalMonths += 12;
        totalYears--;
      }

      history.add(HistoryEntry(-years, -months, days, 'Atenuante'));

      daysController.clear();
      monthsController.clear();
      yearsController.clear();
    });
  }

  void clearTime() {
    // Código de zerar o tempo
    totalMonths = 0;
    totalYears = 0;
    totalDays = 0;
    history.clear();
    // Atualizar a tela
    setState(() {
      // Atualiza o estado da tela aqui
    });
  }

  void _openPrivacyPolicy() async {
    const url = 'https://github.com/Rigobertto';
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
        backgroundColor: Colors.green,
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
                  backgroundColor: Colors.transparent,
                  child: Image.network('https://agendamento.defensoria.rn.def.br/assets/logo-1a33c22bc3d059e0baf9a70ef5cd0f4be1c1277b0c6cc7db7a7a731d89f0d7a9.png'),
                ),
              ),
            ),



            SizedBox(height: 150),

            Text(
              'Total:',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Anos: $totalYears \n Meses: $totalMonths \n Dias: $totalDays',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                SizedBox(width: 16),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: daysController,
                    keyboardType: TextInputType.number, //
                    decoration: InputDecoration(labelText: 'Dias'), //
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
                    primary: Colors.green, //
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: subtractTime,
                  child: Text('Subtrair'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, //
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: clearTime,
                  child: Text('Zerar'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, //
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
                  Text('${entry.years}  ano(s)  ${entry.months} mes(es)  e  ${entry.days}  dia(s)  -  ${entry.actionType}'),
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

