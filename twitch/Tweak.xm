/*
 * Twitch -- Theos
 * Version 1.0.1
 *
 * Disable analytic tracking
 * Disable advertisements
 * Disable jailbreak checks
 * Disable mature checks
 * Do not delete comments
 * Always enable AirPlay
 * Debug messages on network requests
 *
 */

%ctor {
  // Initializing
  HBLogDebug(@"Initialized");
}

%hook CLSAnalyticsMetadataController
+ (BOOL)trackingForAdvertisingEnabled {
  // No more tracking
  return false;
}
+ (BOOL)advertisingSupportFrameworkLinked {
  // Not linked
  return false;
}
+ (BOOL)hostJailbroken {
  // I swear this is stock
  return false;
}
%end

%hook CLSAnalyticsViewControllerTrackingController
- (void)startTracking {
  // No more tracking, please
}
%end

%hook CSComScore
+ (BOOL)isJailbroken {
  // I've never jailbroken in my life!
  return false;
}
%end

%hook CSCore
- (BOOL)isJailBroken {
  // Completely stock iOS, I swear!
  return false;
}
- (BOOL)isAdFrameworkAvailable {
  // This is not the ad framework you are looking for
  return false;
}
- (BOOL)isLimitAdTrackingEnabled {
  // Yes, please limit my ad tracking
  return true;
}
%end

%hook Fabric
- (id)init {
  // Fabric is used for monitoring stuff, but if mine crashes it's my own fault..
  return nil;
}
%end

%hook TWAccountManager
- (void)setAgeConfirmed:(BOOL)arg1 {
  // I have already been confirmed
  %orig(true);
}
%end

%hook TWAdsManager
- (id)init {
  // Don't return a working ad manager
  return nil;
}
%end

%hook TWAnalyticsController
- (id)init {
  // Don't return a working analytics controller
  return nil;
}
%end

%hook TWAppStoreController
- (id)init {
  // What is an.. app store?
  // No point in killing this, but it's cool how well designed the app is when dealing with null controllers
  return nil;
}
%end

%hook TKChannel
- (void)setMature:(BOOL)arg1 {
  // Ensure we don't get age confirmation or mature confirmation stuff
  %orig(false);
}
%end

%hook TWChannelChatViewController
- (void)channelChatRoomController:(id)arg1 clearMessagesFromUser:(NSString *)arg2 {
  // Third
  %orig;
}
%end

%hook TWChansub
- (BOOL)hasAdFreeSubscription {
  // Don't show ads on any channels
  return true;
}
%end

%hook TWChatController
- (void)chatAdapter:(id)chatAdapter receivedClearMessagesRequestForUser:(NSString *)myUser clearUser:(NSString *)badUser onChannel:(NSString *)channel {
  // Second
  %orig;
}
%end

%hook TWChatView
- (void)replaceMessagesFromUser:(NSString *)userName withText:(NSString *)text {
  // Used when deleting messages from user
  %orig;
}
%end

// Used when interacting with comments on chat webView
// This is a more interesting place to hook in
%hook TWChatViewUIWebView
// All javascript is executed on transcript.js in the .app folder
- (void)tw_evaluateJavascript:(NSString *)command {
  //HBLogDebug(@"TKChatViewUIWebView tw_evaluateJavascript: %@", command);

  if ([command hasPrefix:@"replaceMessagesFromUserWithMessage"]) {
    // Deleting comment
    return;

  } else if ([command hasPrefix:@"addComponents"]) {
    // Adding comment

  } else {
    // Not sure, but could be interesting!
    // Actually seems to be mostly scrolling to the bottom when chat opened initially
  }

  %orig;
}
%end

%hook TWHLSManifest
- (id)streamsSortedByBitrate:(id)arg1 {
  // Not used at the moment, but can be changed to sort by source as default quality (possibly)
  return %orig;
}
%end

%hook TWHLSPlaylist
+ (id)dictionaryFromM3UPropertiesString:(id)arg1 {
  // Initialize m3u playlist when loading stream
  return %orig;
}
%end

%hook TWHTTPRealSession
- (void)URLSession:(id)arg1 task:(id)arg2 willPerformHTTPRedirection:(id)arg3 newRequest:(id)arg4 completionHandler:(id)arg5 {
  // This is the url that will be called (usually) when program starts
  %orig;
}
%end

%hook TWHTTPRequest
- (void)setHTTPHeader:(id)arg1 withValue:(id)arg2 {
  // Setting headers before calling any requests
  //HBLogDebug(@"TWHTTPRequest setHTTPHeader: %@: %@", arg1, arg2);
  %orig;
}
- (NSData *)responseData {
  // Response data from the above request
  // There's a field called 'fight_ad_block' when you start a stream, which is interesting
  NSData *data = %orig;
  //NSString *string = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
  //HBLogDebug(@"TWHTTPRequest responseData: %@", string);
  return data;
}
%end

%hook TWMenuViewController
- (void)_requestPromotedChannels {
  // Don't show promoted channels
}
- (void)_requestPromotedGames {
  // Don't show promoted games
}
%end

%hook TWPageViewReferrerInfo
// I've viewed nothing
+ (id)referrerInfoWithMedium:(id)arg1 content:(id)arg2 shareSource:(id)arg3 {
  return nil;
}
+ (id)referrerInfoWithMedium:(id)arg1 content:(id)arg2 {
  return nil;
}
+ (id)referrerInfoWithMedium:(id)arg1 {
  return nil;
}
+ (id)referrerInfo {
  return nil;
}
%end

%hook TWPlayerOverlayView
- (void)showAdOverlay {
  // This won't be called, but just in case
}
%end

%hook TWRatingPromptBanner
- (id)init {
  // I like the app, I really do.. I just don't want to rate it
  return nil;
}
%end

%hook TWTwitchChatAdapter
- (void)chatChannelUserMessagesClearedForUser:(id)arg1 channel:(id)arg2 clearUser:(id)arg3 {
  // Clearing messages for a user goes here first
  %orig;
}
%end

%hook TWVASTRequestInformation
- (id)initWithPlacement:(id)arg1 source:(id)arg2 andLiverailId:(id)arg3 {
  // No ad requests, please
  return nil;
}
%end

%hook TWVideoPlaybackController
- (BOOL)playAd:(id)arg1 {
  // This won't be called, but just in case
  return false;
}
%end

%hook TWVideoPlayerController
- (void)setContentURL:(id)arg1 mimeType:(id)arg2 contentType:(unsigned long long)arg3 {
  // Interesting content url (m3u) that is used for stream
  HBLogDebug(@"TWVideoPlayerController setContentUrl: %@, mimeType: %@, contentType: %lld", arg1, arg2, arg3);
  %orig;
}
- (void)setAllowsAirPlay:(BOOL)arg1 {
  // Everything allows airplay, but just in case
  %orig(true);
}
- (BOOL)allowsAirPlay {
  // Everything allows airplay, but just in case
  return true;
}
%end

