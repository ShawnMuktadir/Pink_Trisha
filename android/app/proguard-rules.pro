############################
# SSLCommerz Core Protection
############################
-keep class com.sslwireless.sslcommerz.** { *; }
-keep class com.sslcommerz.** { *; }
-keepclassmembers class com.sslwireless.sslcommerz.** { *; }
-keepclassmembers class com.sslcommerz.** { *; }
-keepnames class com.sslwireless.sslcommerz.**
-keepnames class com.sslcommerz.**
-dontwarn com.sslwireless.sslcommerz.**
-dontwarn com.sslcommerz.**

# Preserve reflection-based constructors (if used by SDK)
-keepclasseswithmembers class * {
    public <init>(android.content.Context, ...);
}

# Keep listener callback methods (if SSLCommerz uses these)
-keepclassmembers class * {
    public void onTransactionSuccess(...);
    public void onTransactionFail(...);
    public void onMerchantValidationError(...);
}

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

# Allow all networking and image classes
-keep class okhttp3.** { *; }
-keep class okio.** { *; }
-keep class com.bumptech.glide.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn com.bumptech.glide.**

-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

