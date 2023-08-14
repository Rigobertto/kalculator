import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimeCalculatorScreen(),
    );
  }
}

class TimeCalculatorScreen extends StatefulWidget {
  @override
  _TimeCalculatorScreenState createState() => _TimeCalculatorScreenState();
}


class _TimeCalculatorScreenState extends State<TimeCalculatorScreen> {
  int totalMonths = 0;
  int totalYears = 0;
  TextEditingController monthsController = TextEditingController();
  TextEditingController yearsController = TextEditingController();

  void addTime() {
    int months = int.tryParse(monthsController.text) ?? 0;
    int years = int.tryParse(yearsController.text) ?? 0;

    setState(() {
      totalMonths += months;
      totalYears += years;
      totalYears += (totalMonths ~/ 12); // Update total years
      totalMonths %= 12; // Keep months within 0-11 range
      monthsController.clear();
      yearsController.clear();
    });
  }

  void subtractTime() {
    int months = int.tryParse(monthsController.text) ?? 0;
    int years = int.tryParse(yearsController.text) ?? 0;

    setState(() {
      totalMonths -= months;
      totalYears -= years;

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

  void clearTime(){
    setState(() {
      totalMonths = 0;
      totalYears = 0;
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

        title: Text('Calculadora DPERN'),
        backgroundColor: Colors.green, // Cor verde para o AppBar

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
                  child: Image.network('https://agendamento.defensoria.rn.def.br/assets/logo-1a33c22bc3d059e0baf9a70ef5cd0f4be1c1277b0c6cc7db7a7a731d89f0d7a9.png'),
                ),
              ),
            ),


            SizedBox(height: 200),
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
}
