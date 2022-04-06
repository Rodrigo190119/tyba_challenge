import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tyba_flutter_challenge/providers/export_providers.dart';
import 'package:tyba_flutter_challenge/utils/export_utils.dart';
import 'package:tyba_flutter_challenge/views/home.dart';
import 'package:tyba_flutter_challenge/widgets/export_widgets.dart';

class LoggedInHomeView extends StatefulWidget {
  const LoggedInHomeView({Key? key}) : super(key: key);

  @override
  State<LoggedInHomeView> createState() => _LoggedInHomeViewState();
}

class _LoggedInHomeViewState extends State<LoggedInHomeView> {

  late var _future;

  @override
  void initState() {
    _future = Provider.of<GeoDBProvider>(context, listen: false).populateCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: backgroundColor,
            drawer: Drawer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.logout, size: 20,),
                  TextButton(
                      onPressed: () async {
                        await Provider.of<LoginProvider>(context, listen: false).signOut().whenComplete((){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(
                                builder: (context) => const HomeView(),
                              )
                          );
                        });
                      },
                      child: const Text('Cerrar Sesión', style: TextStyle(color: textColor)))
                ],
              ),
            ),
            appBar: AppBar(
              title: const Text('Tyba Challenge', style: TextStyle(color: textColor, fontSize: 25.0)),
              backgroundColor: backgroundColor,
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              height: screenSize.height,
              width: screenSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 15.0),
                  const Text(
                      'Bienvenid@ a nuestra aplicación. Por favor, busca una ciudad.',
                      style: TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.justify
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    child: ElevatedButton(
                      onPressed: () {
                        showSearch(context: context, delegate: ChallengeSearchDelegate());
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                          primary: highlightColor,
                          elevation: 0
                      ),
                      child: SizedBox(
                        width: screenSize.width * 0.80,
                        height: 50,
                        child: Row(
                          children: const [
                            Icon(Icons.search),
                            Text('Buscar...')
                          ],
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                      tybaSingleLogo,
                      width: 400, height: 400,
                      fit: BoxFit.contain
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
