
import 'package:flutter/cupertino.dart';
import 'package:notes_application_with_node_js/models/notes.dart';
import 'package:notes_application_with_node_js/service/api_service.dart';

class NoteProvider with ChangeNotifier{
 
 bool isLoading = true;

 List<Note> notes = [];   //* <-- Data Server sa fatch karne ke bad ismein store Hota Hai


 NoteProvider(){    //* <-- yah Hai Class ka constructor
  fatchNotes();     //* <-- Jahan Bhi iska object Banega yah fatchNotes() Function automatic run ho jaega
 }



List<Note> getFilteredNotes(String searchQuery){      //* <-- Yah hai notes Search function 
    return notes.where((element) => element.title!.toLowerCase().contains(searchQuery.toLowerCase())
    || element.content!.toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
}


  sortNotes(){   
   notes.sort((a,b)=>b.dateadded!.compareTo(a.dateadded!));    //* <-- Yah code add data or update data ko Ui Mein First Mein Show karta hai 
 }


 void addNote(Note note){
  notes.add(note);
  sortNotes();
  notifyListeners();
  ApiService.addNote(note);       //* <-- This Call addNote Function
 }



 void updateNote(Note note){
   int indexOfNotes = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
   notes[indexOfNotes] = note;
   sortNotes();
   notifyListeners();
   ApiService.addNote(note);     //* <-- This Call addNote Function  id sam Rahane se phila wala note automatic delete kar deta hai   Or   New note add kar deta hai   ( Yahi User ka Note update karne mein kam Aata Hai ) Or ( yah Process backend Server Mein Hota Hai)
 }




 void deletetNote(Note note){
  int indexOfNotes = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
   notes.removeAt(indexOfNotes);
   sortNotes();
   notifyListeners();
   ApiService.deleteNote(note);    //* <-- This Call deleteNote Function
 }
  

void fatchNotes()async{
    notes = await ApiService.fatchNotes("mdsomad");    //* <-- This Call fatchNotes Function
    sortNotes();
    isLoading = false;
    notifyListeners();
}
  
}