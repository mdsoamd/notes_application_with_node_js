
import 'dart:convert';
import 'dart:developer';

import 'package:notes_application_with_node_js/models/notes.dart';
import 'package:http/http.dart' as http;

class ApiService{



//* This Server note.js deploy hai Render mein or Using Database hai MongoDB atlas
static String _baseUrl = "https://my-new-notes-test-application.onrender.com/notes";




                                                          
static Future<void> addNote(Note note)async{              //* <-- yah function user ka Data add or Data update donon kaam karta hai  or id sam Rahane se phila wala note automatic delete kar deta hai   Or   New note add kar deta hai   ( Yahi User ka Note update karne mein kam Aata Hai ) Or ( yah Process backend Server Mein Hota Hai)
     Uri requiredUri = Uri.parse(_baseUrl + "/add");
      var response = await http.post(requiredUri,body: note.toMap());
      var decoded = jsonDecode(response.body);
      log(decoded.toString());
     
 }










static Future<void> deleteNote(Note note)async{           //* <-- User data delete function
     Uri requiredUri = Uri.parse(_baseUrl + "/delete");
      var response = await http.post(requiredUri,body: note.toMap());
      var decoded = jsonDecode(response.body);
      log(decoded.toString());
     
 }
 







static Future<List<Note>> fatchNotes(String userid)async{     //* <-- Server sa fatch User data Function  
     Uri requiredUri = Uri.parse(_baseUrl + "/list");
      var response = await http.post(requiredUri,body:{'userid':userid});
      var decoded = jsonDecode(response.body);
      List<Note> notes = [];
      for(var noteMap in decoded){
           Note newNote = Note.fromJson(noteMap);
           notes.add(newNote);
      }
      return notes;
 }
 
 
  


}