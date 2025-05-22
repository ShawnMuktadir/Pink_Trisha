# Keep all SSLCommerz-related classes
-keep class com.sslwireless.sslcommerz.** { *; }
-keep class com.sslcommerz.** { *; }
-keep class * extends com.google.gson.TypeAdapter
-keepattributes *Annotation*
-keepnames class com.sslwireless.sslcommerz.**
-keepnames class com.sslcommerz.**
-dontwarn com.sslwireless.sslcommerz.**
-dontwarn com.sslcommerz.**

-keep class com.sslwireless.sslcommerz.** { *; }
-keep class com.sslcommerz.** { *; }
-dontwarn com.sslwireless.sslcommerz.**
-dontwarn com.sslcommerz.**

# Keep all Flutter and JSON-related classes
-keep class io.flutter.** { *; }
-keep class com.google.gson.** { *; }
-keep class org.json.** { *; }
-keepnames class * { @com.google.gson.annotations.SerializedName *; }

# Keep all Retrofit and OkHttp classes if you use them
-keep class retrofit2.** { *; }
-keep class okhttp3.** { *; }

# Keep Gson serialization intact
-keepattributes Signature
-keepattributes *Annotation*
-keep class * implements java.io.Serializable { *; }

# Keep Play Core classes
-keep class com.google.android.play.** { *; }
-dontwarn com.google.android.play.**

# Keep Flutter deferred components
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }
-dontwarn io.flutter.embedding.engine.deferredcomponents.**

-keep class io.flutter.** { *; }

