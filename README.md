# Android Challenge

## Requirements:

  * Oracle JDK 1.8
  * Android SDK
  * Genymotion emulator ('Personal type' libcense is Ok)
  * Ruby 2.1
  * Selendroid standalone server 0.17.0

  Note on Requirements: Selendroid requires jarsigner utility should be in jdk binaries directory, if its only located on jre binaries, with a soft symlink will work well.

  e.g:
```
  ln -s /usr/lib/jvm/java-8-jdk/bin/jarsigner /usr/lib/jvm/java-8-jdk/jre/bin/jarsigner
```


## Execution:

  * start Genymotion emulator with any device (Nexus 5 with Android 5.1.0 works fine)
  * in android-challenge/bin directory:
```
      $ java -jar selendroid-standalone-0.17.0-with-dependencies.jar -aut android-debug.apk
```

    this will run selendroid server in Genymotion emulator and also copy the application under test

  * in new terminal:
```
    $ cucumber
```

    this will fire all tests running on the virtual device


## Known issues:

    * Test 'Unexpected GPS disabled by low battery' fails because when the virutal GPS sensor is set to disabled, the status update to the emulator could take +30 seconds.

