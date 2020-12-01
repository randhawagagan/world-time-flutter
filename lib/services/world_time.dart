import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart';

class WorldTime{
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});
  Future<void> getTime() async{
    //simulate network request

   try{
     Response response = await get('http://worldtimeapi.org/api/timezone/$url');
     Map data = jsonDecode(response.body);
     // print(data);
     String dateTime = data['datetime'];
     String offset = data['utc_offset'].substring(1,3);
     // print(dateTime);
     print(offset);

     DateTime now = DateTime.parse(dateTime);
     now = now.add(Duration(hours: int.parse(offset)));

     isDayTime = now.hour > 6 && now.hour < 20 ? true: false;
     time = DateFormat.jm().format(now);
   }
catch(e){
     print('caught');
     time = 'could not fetch data';
}

  }


}

