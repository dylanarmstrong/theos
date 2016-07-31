/*
 * Twitch -- Theos
 * Version 1.0
 *
 * Disable analytic tracking
 * Disable advertisements
 * Disable jailbreak checks
 * Disable mature checks
 * Do not delete comments
 * Always enable AirPlay
 *
 */

%ctor {
  // Initializing
  HBLogDebug(@"Initialized");
}

%hook CSCore
- (BOOL)isJailBroken {
  // Completely stock iOS, I swear!
  HBLogDebug(@"CSCore isJailBroken");
  return false;
}
- (BOOL)isAdFrameworkAvailable {
  // This is not the ad framework you are looking for
  HBLogDebug(@"CSCore isAdFrameWorkAvailable");
  return false;
}
- (BOOL)isLimitAdTrackingEnabled {
  // Yes, please limit my ad tracking
  HBLogDebug(@"CSCore isLimitAdTrackingEnabled");
  return true;
}
%end

%hook TWPlayerOverlayView
- (void)showAdOverlay {
  // This won't be called, but just in case
  HBLogDebug(@"TWPlayerOverlayView showAdOverlay");
}
%end

%hook TWVideoPlaybackController
- (BOOL)playAd:(id)arg1 {
  // This won't be called, but just in case
  HBLogDebug(@"TWVideoPlaybackController playAd: %@", arg1);
  return false;
}
%end

%hook TKChannel
- (void)setMature:(BOOL)arg1 {
  // Ensure we don't get age confirmation or mature confirmation stuff
  %orig(false);
}
%end

%hook CSComScore
+ (BOOL)isJailbroken {
  // I've never jailbroken in my life!
  HBLogDebug(@"CSComScore isJailbroken");
  return false;
}
%end

%hook TWChansub
- (BOOL)hasAdFreeSubscription {
  // Don't show ads on any channels
  HBLogDebug(@"TWChansub hasAdFreeSubscription");
  return true;
}
%end

// Used when interacting with comments on chat webView
// This is a more interesting place to hook in
%hook TWChatViewUIWebView
// All javascript is executed on transcript.js in the .app folder
- (void)tw_evaluateJavascript:(NSString *)command {
  if ([command hasPrefix:@"replaceMessagesFromUserWithMessage"]) {
    // Deleting comment
    //HBLogDebug(@"TKChatViewUIWebView tw_evaluateJavascript: %@", command);
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

%hook TWChatView
- (void)replaceMessagesFromUser:(NSString *)userName withText:(NSString *)text {
  // Used when deleting messages from user
  //HBLogDebug(@"TWChatView replaceMessagesFromUser: %@", userName);
  %orig;
}
%end

%hook TWMenuViewController
- (void)_requestPromotedChannels {
  // Don't show promoted channels
  HBLogDebug(@"TWMenuViewController _requestPromotedChannels");
}
- (void)_requestPromotedGames {
  // Don't show promoted games
  HBLogDebug(@"TWMenuViewController _requestPromotedGames");
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
  HBLogDebug(@"TWVideoPlayerController setAllowsAirPlay");
  %orig(true);
}
- (BOOL)allowsAirPlay {
  // Everything allows airplay, but just in case
  HBLogDebug(@"TWVideoPlayerController allowsAirPlay");
  return true;
}
%end

%hook TWHLSManifest
- (id)streamsSortedByBitrate:(id)arg1 {
  // Not used at the moment, but can be changed to sort by source as default quality (possibly)
  HBLogDebug(@"TWHLSManifest streamsSortedByBitRate: %@", arg1);
  return %orig;
}
%end

%hook TWHLSPlaylist
+ (id)dictionaryFromM3UPropertiesString:(id)arg1 {
  // Initialize m3u playlist when loading stream
  return %orig;
}
%end

%hook TWAdsManager
- (id)init {
  // Don't return a working ad manager
  HBLogDebug(@"TWAdsManager init");
  return nil;
}
%end

%hook TWAnalyticsController
- (id)init {
  // Don't return a working analytics controller
  HBLogDebug(@"TWAnalyticsController init");
  return nil;
}
%end

%hook CLSAnalyticsMetadataController
+ (BOOL)trackingForAdvertisingEnabled {
  // No more tracking
  HBLogDebug(@"CLSAnalyticsMetadataController trackingForAdvertisingEnabled");
  return false;
}
+ (BOOL)advertisingSupportFrameworkLinked {
  // Not linked
  HBLogDebug(@"CLSAnalyticsMetadataController advertisingSupportFrameworkLinked");
  return false;
}
+ (BOOL)hostJailbroken {
  // I swear this is stock
  HBLogDebug(@"CLSAnalyticsMetadataController hostJailbroken");
  return false;
}
%end

%hook CLSAnalyticsViewControllerTrackingController
- (void)startTracking {
  HBLogDebug(@"CLSAnalyticsViewControllerTrackingController startTracking");
}
%end

%hook TWRatingPromptBanner
- (id)init {
  // I like the app, I really do.. I just don't want to rate it
  HBLogDebug(@"TWRatingPromptBanner init");
  return nil;
}
%end

%hook Fabric
- (id)init {
  // Fabric is used for monitoring stuff, but if mine crashes it's my own fault..
  HBLogDebug(@"Fabric init");
  return nil;
}
%end

%hook TWAccountManager
- (void)setAgeConfirmed:(BOOL)arg1 {
  // I have already been confirmed
  HBLogDebug(@"TWAccountManager setAgeConfirmed");
  %orig(true);
}
%end

%hook TWTwitchChatAdapter
- (void)chatChannelUserMessagesClearedForUser:(id)arg1 channel:(id)arg2 clearUser:(id)arg3 {
  // Clearing messages for a user goes here first
  HBLogDebug(@"TWTwitchChatAdapter chatChannelUserMessagesClearedForUser");
  %orig;
}
%end

%hook TWChatController
- (void)chatAdapter:(id)chatAdapter receivedClearMessagesRequestForUser:(NSString *)myUser clearUser:(NSString *)badUser onChannel:(NSString *)channel {
  // Second
  HBLogDebug(@"TWChatController receivedClearMessagesRequestForUser");
  %orig;
}
%end

%hook TWChannelChatViewController
- (void)channelChatRoomController:(id)arg1 clearMessagesFromUser:(NSString *)arg2 {
  // Third
  HBLogDebug(@"TWChannelChatViewController channelChatRoomController: %@", arg2);
  %orig;
}
%end

