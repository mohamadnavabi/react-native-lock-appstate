package com.lockappstate;

import android.app.KeyguardManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.modules.core.DeviceEventManagerModule;

@ReactModule(name = LockAppstateModule.NAME)
public class LockAppstateModule extends ReactContextBaseJavaModule {
  public static final String NAME = "LockAppstate";

  public LockAppstateModule(ReactApplicationContext reactContext) {
    super(reactContext);
    lockBroadcastReceiver(reactContext);
  }

  @Override
  @NonNull
  public String getName() {
    return NAME;
  }

  private void lockBroadcastReceiver(ReactApplicationContext reactContext) {
    IntentFilter intentFilter = new IntentFilter();
    intentFilter.addAction(Intent.ACTION_SCREEN_ON);
    intentFilter.addAction(Intent.ACTION_SCREEN_OFF);

    BroadcastReceiver lockReceiver = new BroadcastReceiver() {
      @Override
      public void onReceive(Context context, Intent intent) {
        KeyguardManager keyguardManager = (KeyguardManager) context.getSystemService(Context.KEYGUARD_SERVICE);
        String stringAction = intent.getAction();
        if (stringAction.equals(Intent.ACTION_SCREEN_OFF)) {
          reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
            .emit("onLocked", keyguardManager.inKeyguardRestrictedInputMode() ? "buttonLock": "screenLock");
        }
      }
    };

    reactContext.registerReceiver(lockReceiver, intentFilter);
  }
}
