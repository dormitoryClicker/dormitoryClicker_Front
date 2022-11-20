import 'package:flutter/material.dart';

class ReservationData extends ChangeNotifier{
  Map<String, List> reservations =
  {
    'startDatetime' : List.empty(growable: true),
    'endDatetime' : List.empty(growable: true)
  };
}