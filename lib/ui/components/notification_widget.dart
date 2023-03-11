import 'package:flutter/material.dart';
import 'package:customer/core/model/notification_model.dart';
import 'package:customer/core/view/notification_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationWidget extends StatefulWidget {
  final NotificationModel notificationModel;

  const NotificationWidget({
    Key? key,
    required this.notificationModel,
  }) : super(key: key);

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {


  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Row(
        children:  <Widget>[
          Icon(
            Icons.delete_outline,
          ),
          Text(AppLocalizations.of(context).notification_delete),
        ],
      ),
      onDismissed: (direction) {
        Provider.of<NotificationView>(context, listen: false)
            .deleteNotification(widget.notificationModel.id);
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).notification_deleted,),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      key: UniqueKey(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.notificationModel.title,
                ),
              ),
              Text(
                DateFormat('dd MMM yy - kk:mm')
                    .format(widget.notificationModel.sentDate),
              ),
            ],
          ),
          const SizedBox(height: 2,),
          Text(
            widget.notificationModel.message,
            ),
        ],
      ),
    );
  }
}
