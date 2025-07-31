#!/bin/bash

fvm flutter clean && fvm flutter packages pub get && fvm flutter pub run build_runner build --delete-conflicting-outputs
