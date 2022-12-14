import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands =[
    Band(id:'1',     name: 'Metallica',  votes: 5),
    Band(id:'2',     name: 'queen',  votes: 3),
    Band(id:'3',     name: 'Pearl Jam',  votes: 4),
    Band(id:'4',     name: 'Los prisioneros',  votes: 1),
  ]; 


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Band Names', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) =>_bandTile(bands[i])
      ),
      
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: addNewBand,
        child: const Icon( Icons.add)),
          
   );
  }

  Widget _bandTile(Band band) {
    return Dismissible( //deslizar y eliminar un list
      key: Key(band.id), //deslizar y eliminar un list
      direction: DismissDirection.startToEnd, 
      onDismissed: (direction){
        print('Direction: $direction');
        print('Id: ${band.id}');
        //TODO: LLAMAR EL BORRADO EN EL SERVER 

      },
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band', style: TextStyle(color: Colors.white),),
        )
      ),
      child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Text( band.name.substring(0,2)),
            ),
            title: Text(band.name),
            trailing: Text('${ band.votes}', style: const TextStyle(fontSize: 20),),
            onTap: () {
              print(band.name);
            },        
          ),
    );
  }

  addNewBand(){

  final  textController = TextEditingController();
  if (Platform.isAndroid){
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text('New Band Name'),
          content: TextField(
            controller: textController,
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5,
              textColor: Colors.blue,
              child:  const Text('Add'),
              onPressed:() => addBandToList(textController.text)
               
            )
          ],
        ); 
      },
    );
  }
  
    showCupertinoDialog(
      context: context, 
      builder: ( _ ){
        return CupertinoAlertDialog(
         title: const Text('New band name'),
         content: CupertinoTextField(
          controller: textController,
         ), 
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Add'),
            onPressed: () => addBandToList(textController.text),
            ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Dismiss'),
            onPressed: () => Navigator.pop(context),
            )
        ],
        
        );
      }
    );
  }


  void addBandToList( String name){
    print(name);
    
    if(name.length > 1){

      bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0));

    }

    setState(() {
      
    });

    Navigator.pop(context);
  }
}