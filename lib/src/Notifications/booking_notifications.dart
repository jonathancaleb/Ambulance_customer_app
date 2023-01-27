import 'package:awesome_notifications/awesome_notifications.dart';

//Show the notification when driver is matched
void showDriverMatchedNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1,
        channelKey: "key1",
        title: "Booking Event",
        body: "Driver Has been matched"),
  );
}

void sendBookingStageNotification(String bookingEvent) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1, channelKey: "key1", title: "Booking Event", body: bookingEvent),
  );
}
