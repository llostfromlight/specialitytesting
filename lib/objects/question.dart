import 'package:flutter/material.dart';
import 'package:specialitytesting/functions.dart';

//Posible solutions :
/*
  1- Make list that contains all of the question thier image and thier text and special number 
  called adding ration this used to know where is the next question, for example for question n1 this will be 1 question
  in second we have 2 question and 4 answers in third we have 4 questions and 8 answer
  that ration doubled from the past one and 

  2- serial number using set put the objects inside the serial number would be the key
  and value is object you look for 
  every object has its serial number inside it too like for first question
  1 is serial number for first yes 
  0 for no 
  second session 11 for yes or 10 if the second and ofc 00 and 01 and so on
  like you just return serial number for next question from the function of that obj it will 
  simply add 0 or 1 to its current serial number 
  if no question found it will just print error

  3- Or simply add make set where thers is maps has serial code as key and value is data needed (images,txt and methods for next serial code)?
  

  from those solutions i think the last one is most optimal ?
*/
class Question {
  String code;
  String txt = "error";
  Image image;
  Question({required this.txt, required this.image, required this.code});
  set updateimage(double height) {
    image = (code == "") ?intilizeImage(path: "images/image.jpg",height: height) : intilizeImage(path: "images/$code.jpg",height: height);
  }
  String yes() => '${code}1';
  String no() => '${code}0';
}
