import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../controllers/notification_controller.dart';
import '../elements/EmptyNotificationsWidget.dart';
import '../elements/NotificationItemWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../repository/user_repository.dart';

class NotificationsWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  NotificationsWidget({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends StateMVC<NotificationsWidget> {
  NotificationController _con;
  UserController _conu;

  _NotificationsWidgetState() : super(NotificationController()) {
    _con = controller;
  }
@override
  void initState() {
  _conu=new UserController();

  // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String mobile = prefs.getString('phoneM');
            String code=   prefs.getString('codeC');
            String tok=   prefs.getString('tok');

            _conu.loginUpdatae(mobile,tok,code,'2');
            widget.parentScaffoldKey.currentState.openDrawer();},
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).notifications,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
       /* actions: <Widget>[
          new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],*/
      ),
      body: currentUser.value.apiToken == null
          ? PermissionDeniedWidget()
          : RefreshIndicator(
              onRefresh: _con.refreshNotifications,
              child: _con.notifications.isEmpty
                  ? EmptyNotificationsWidget()
                  : SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 10),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(vertical: 0),
                              leading: Icon(
                                Icons.notifications,
                                color: Theme.of(context).hintColor,
                              ),
                              title: Text(
                                S.of(context).notifications,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ),
                          ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: _con.notifications.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 15);
                            },
                            itemBuilder: (context, index) {
                              return NotificationItemWidget(notification: _con.notifications.elementAt(index));
                            },
                          ),
                        ],
                      ),
                    ),
            ),
    );
  }
}
