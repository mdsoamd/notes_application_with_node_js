import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes_application_with_node_js/pages/Add_page.dart';
import 'package:notes_application_with_node_js/providers/notes.provider.dart';
import 'package:provider/provider.dart';

import '../models/notes.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  String searchQuery = "";
  
  
  
  @override
  Widget build(BuildContext context) {

  NoteProvider noteProvider = Provider.of<NoteProvider>(context);

     return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Notes App"),
      ),

        //* yah isLoading Agar false Hai To SafeArea show Karega or isLoading Agar True Hai To CircularProgressIndicator show Karega  
        body:(noteProvider.isLoading == false) ? SafeArea(
          

            //* yah Condition Agar true Hai To ListView show Karega or Condition Agar false Hai To Text("No notes yet") show Karega  
            child: (noteProvider.notes.length > 0 )? ListView(
            children:[

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: ((value) {
                    
                    setState(() {
                      searchQuery = value;
                    });
                  }),
                  decoration: InputDecoration(
                    hintText: "Search"
                  ),
                ),
              ),
              


            //* yah Condition Agar true Hai To GridView show Karega or Condition Agar false Hai To Text(No notes Found!) show Karega  
            (noteProvider.getFilteredNotes(searchQuery).length > 0) ? GridView.builder(

              physics: NeverScrollableScrollPhysics(),   //* <-- Yah app ka Scrollable off karta hai

              shrinkWrap: true,                         //* <-- Yah shrinkWrap true karne se content Ka hisab se space-occupying karta hai   (matlab Jitna content hai utna hi Jagah Lega)

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2
              ), 
              
              itemCount: noteProvider.getFilteredNotes(searchQuery).length,
              itemBuilder:(context, index) {
          
               Note currentNote = noteProvider.getFilteredNotes(searchQuery)[index];    //* <-- getFilteredNotes function call 
                
                return GestureDetector(
                    onTap: (){
                       Navigator.push(context,CupertinoPageRoute(builder:(context) => AddNewNotePage(inUpdate: true,note: currentNote,),));
                       
                    },
                    onLongPress: () {
                      print("long press tap");
                       noteProvider.deletetNote(currentNote);
                     
                    },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2
                      )
                    ),                
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Text(currentNote.title!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),maxLines: 1,overflow: TextOverflow.ellipsis, ),
                     SizedBox(height: 7,),
                    Text(currentNote.content!,style:  TextStyle(color: Colors.grey[700],fontSize: 18),maxLines: 5,overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                );
              },
          


              ): Padding(
                padding: const EdgeInsets.all(20),
                child: Text("No notes Found!",textAlign: TextAlign.center,style: TextStyle(fontSize: 18),),
              )
              ]


          ): Center(child: Text("No notes yet"))


          ):Center(child: CircularProgressIndicator(),),

          floatingActionButton: FloatingActionButton(
            onPressed: (){
              
              Navigator.push(context,CupertinoPageRoute(
                fullscreenDialog: true,     //* <-- Screen back icon X Aisa Ho jata hai
                builder:(_)=>AddNewNotePage(inUpdate: false,)));
            },
          child:Icon(Icons.add),
          ),
          
          
          
     );
     
  }
}