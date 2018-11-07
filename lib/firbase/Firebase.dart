import 'dart:async';
import 'dart:io' show Platform;
import 'package:bus/env.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

Future<void> fireBaseInit() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'NTU-Shuttle-Bus',
    options: Platform.isIOS
        ? const FirebaseOptions(
            googleAppID: IOS_GOOGLE_API_KEY,
            gcmSenderID: GCM_SENDER_ID,
            databaseURL: FIREBASE_DB_URL,
          )
        : const FirebaseOptions(
            googleAppID: APK_GOOGLE_API_KEY,
            apiKey: GCM_API_KEY,
            databaseURL: FIREBASE_DB_URL,
          ),
  );
}
