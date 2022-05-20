import 'package:flutter/material.dart';
import 'package:hytch_flutter/screens/Chat.dart';

InkWell ChatPreview(BuildContext context, String name, String avatarImg,
    String lastMessage, String time,
    {bool read = true}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(),
        ),
      );
    },
    splashColor: Theme.of(context).primaryColor.withAlpha(10),
    child: ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black12,
          width: 0.5,
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatarImg),
      ),
      title: Text(name,
          style: TextStyle(
              fontWeight: read ? FontWeight.normal : FontWeight.bold)),
      subtitle: Text(lastMessage,
          style: TextStyle(
              color: Colors.black87,
              fontWeight: read ? FontWeight.normal : FontWeight.bold)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            time,
            style: TextStyle(
                color: Colors.grey,
                fontWeight: !read ? FontWeight.bold : FontWeight.normal),
          ),
          !read
              ? Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.circle,
                    size: 12,
                    color: Theme.of(context).primaryColor.withAlpha(175),
                  ),
                )
              : Container()
        ],
      ),
    ),
  );
}
