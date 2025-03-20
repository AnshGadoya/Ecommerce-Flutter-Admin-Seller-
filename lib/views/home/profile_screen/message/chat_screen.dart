import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/home/profile_screen/message/component/sender_bubble.dart';
import 'package:emart_seller/views/widget/text_style.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: "Chats", size: 18.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return senderBubble();
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: purpleColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey)),
                      hintText: 'Type a message........'),
                )),
                IconButton(
                    onPressed: () {
                      // controller.sendMsg(controller.msgController.text);
                      // controller.msgController.clear();
                    },
                    icon: Image.asset(icSend))
              ],
            ).box.height(80).margin(const EdgeInsets.only(bottom: 8)).make()
          ],
        ),
      ),
    );
  }
}
