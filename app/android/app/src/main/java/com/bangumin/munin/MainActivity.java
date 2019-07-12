package com.bangumin.munin;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugins.munin.permissionhandler.PermissionHandlerPlugin;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    PermissionHandlerPlugin.registerWith(this.registrarFor("io.flutter.plugins.munin.permissionhandler.PermissionHandlerPlugin"));
    GeneratedPluginRegistrant.registerWith(this);
  }
}
