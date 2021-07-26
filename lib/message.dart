final String tableMessages = 'Messages';

class MessageFields{
  //these will later on be the columns of the database
  static final String id = '_id';
  static final String text = 'text';

  static final List<String> values = [
    id, text
  ];

}

class SingleMessage {
  final String? text;
  final int? id;

  SingleMessage({required this.id, required this.text});

  //dont understand this part
  //create a copy and modifiy some values.
  SingleMessage copy({
    int? id,
    String? text

  })=> SingleMessage(
    id: id?? this.id,
    text: text?? this.text
  );

  //create message object from jscon
  static SingleMessage fromJson(Map<String, Object?> json)=> SingleMessage(
          id: json[MessageFields.id] as int?,
          text: json[MessageFields.text] as String?
  );

  //creates from fields a map
  Map<String, Object?> toJson() => {
    MessageFields.id: id,
    MessageFields.text: text
  };
}


class MessageList {
  List <SingleMessage> messageList = [];
}