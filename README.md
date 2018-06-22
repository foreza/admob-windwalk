# admob-windwalk
A sample project that integrates the Admob Core SDK with the AerServ Plugin. 
 
This path is typically used with Admob to increase fill rate. 

A typical publisher might integrate the core SDK (Admob in this example) and then implement other SDKs through plugins through an auction held by that core.
Overall, this strategy allows for best fill rate across the board while still utilizing a well known Ad SDK.

## AdMob SDK:

https://developers.google.com/admob/ios/quick-start

## AerServ AdMob Plugin:

The SDK Package for IOS/Android comes with a 'Network Support' folder that contains all the plugin files required for integration. The .framework file would be dragged / dropped into the XCode project and then referenced in the build process to 'complete' the plugin procedure.
https://support.aerserv.com/hc/en-us/articles/205309400-AdMob-Mediation-Plugin-Getting-Started


## Requirements / Dependencies 

IN PROGRESS

## Setup Instructions:

Clone the repo:

``` git clone https://github.com/foreza/admob-windwalk/ ```

Run an update to get the latest production SDKs:

``` pod install --repo-update ```

Open the xcode project (windwalker.xcodeproj)

Run 'clean' then select your target OS, and then 'build'



Open the xCode project

## Notes:

WORK IN PROGRESS
