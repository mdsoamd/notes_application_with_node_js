import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_application_with_node_js/models/notes.dart';
import 'package:notes_application_with_node_js/providers/notes.provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';


class AddNewNotePage extends StatefulWidget {
  bool inUpdate;
  Note? note;
   AddNewNotePage({Key? key,required this.inUpdate,this.note}) : super(key: key);

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {

  
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  FocusNode noteFocus = FocusNode();
  


@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    contentController.dispose();
    noteFocus.dispose();
  }







  void addNewNote(){
     Note newNote = Note(
       id: Uuid().v1(),
       userid: "mdsomad",
       title: titleController.text,
       content: contentController.text,
       dateadded: DateTime.now()
     );

     Provider.of<NoteProvider>(context,listen: false).addNote(newNote);     //* <-- call addNote Function
     Navigator.pop(context);
     
  }






void updateNote(){
      widget.note!.title = titleController.text;
      widget.note!.content = contentController.text;
      widget.note!.dateadded = DateTime.now();
      Provider.of<NoteProvider>(context,listen: false).updateNote(widget.note!);    //* <-- call updateNote Function
      Navigator.pop(context);
       
  }





@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.inUpdate){
       titleController.text = widget.note!.title!;
       contentController.text = widget.note!.content!;
    }
  }



  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
           actions: [
            IconButton(onPressed:(){
              
               if(widget.inUpdate){
                 updateNote();
               }else{
                  addNewNote();
               }
             
            }, icon:Icon(Icons.check))
           ],
       ),


       body: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
         child: Column(
          children: [

             TextField(
              controller: titleController,
              autofocus:(widget.inUpdate  == true) ? false: true,

              onSubmitted: (value) {
                if(value != ""){
                  noteFocus.requestFocus();
                }
              },

              style:const TextStyle(fontSize: 30,fontWeight:FontWeight.bold),

              decoration: const InputDecoration(
                hintText: "Title",
                border:InputBorder.none
              ),
             ),
             


             Expanded(
               child: TextField(
                controller: contentController,
                focusNode: noteFocus,
                style: TextStyle(fontSize: 20),
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Note",
                  border: InputBorder.none
                )
               ),

             )




          ],
         ),
       ),
    );
  }
}