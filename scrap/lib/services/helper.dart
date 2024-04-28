import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timestamp) {
  // Timestamp is the object retrieved from firebase
  // convert to a string
  DateTime dateTime = timestamp.toDate();

  //get year
  String year = dateTime.year.toString();

  //get month
  String month = dateTime.month.toString();

  // get day
  String day = dateTime.day.toString();

  // formatted date
  String formattedDate = '$month/$day/$year';

  return formattedDate;
}
