/*
 * Youtube -- Theos
 * Version 1.0
 *
 * Disable ads
 *
 */

%ctor {
  HBLogDebug(@"Initialized");
}

%hook YTInstreamAdsPlaybackCoordinator
- (BOOL)detectAirplayAdSkipWithCurrentMediaTime:(double)arg1 isExternalPlaybackActive:(BOOL)arg2 {
  return %orig(arg1, false);
}
- (void)willPlayAd {
  HBLogDebug(@"YTInstreamAdsPlaybackCoordinator willPlayAd");
}
- (void)prepareAdInterrupt:(id)arg1 {
  HBLogDebug(@"YTInstreamAdsPlaybackController prepareAdInterrupt: %@", arg1);
  %orig(arg1);
}
- (BOOL)isCurrentAdBreakPreroll {
  BOOL ret = %orig;
  HBLogDebug(@"YTInstreamAdsPlaybackController isCurrentAdBreakPreroll: %@", ret ? @"true" : @"false");
  return ret;
}
%end

%hook YTLocalPlaybackController
- (BOOL)detectAirplayAdSkipWithCurrentMediaTime:(double)arg1 {
  return %orig(arg1);
}
- (BOOL)isAppInBackground {
  HBLogDebug(@"YTLocalPlaybackController isAppInBackground");
  return false;
}
- (void)prepareToPlayAdVideo {
  HBLogDebug(@"YTLocalPlaybackController prepareToPlayAdVideo");
  %orig;
}
- (void)playAdInterrupt:(id)arg1 {
  HBLogDebug(@"YTLocalPlaybackController playAdInterrupt: %@", arg1);
  %orig(arg1);
}
- (void)loadAdThenMainVideo {
  HBLogDebug(@"YTLocalPlaybackController loadAdThenMainVideo");
  %orig;
}
- (void)loadAdIntro {
  HBLogDebug(@"YTLocalPlaybackController loadAdIntro");
}
- (void)didFinishWithAd:(id)arg1 hideCompanionAd:(BOOL)arg2 {
  HBLogDebug(@"YTLocalPlaybackController didFinishWithAd");
  %orig(arg1, true);
}
%end

%hook DefaultMDXDeviceConnectivityInfoProvider
- (BOOL)isCurrentUserRedSubscriber {
  HBLogDebug(@"DefaultMDXDeviceConnectivityInfoProvider isCurrentUserRedSubscriber");
  return true;
}
%end

%hook YTVideoAdsCoordinatorState
- (BOOL)prerollSeen {
  HBLogDebug(@"YTVideoAdsCoordinatorState preRollSeen");
  return true;
}
%end

%hook MDXPlaybackController
- (BOOL)isCurrentAdBreakPreroll {
  HBLogDebug(@"MDXPlaybackController isCurrentAdBreakPreroll");
  return false;
}
%end

%hook YTVideoAdsOverlayCoordinator
- (BOOL)isCurrentAdBreakPreroll {
  HBLogDebug(@"YTVideoAdsOverlayCoordinator isCurrentAdBreakPreroll");
  return false;
}
%end

%hook YTVMAPAdBreak
- (BOOL)isPreroll {
  HBLogDebug(@"YTVMAPAdBreak isPreroll");
  return false;
}
%end

%hook YTBaseInstreamAdBreak
- (BOOL)isPreroll {
  HBLogDebug(@"YTBaseInstreamAdBreak isPreroll");
  return false;
}
%end

%hook YTAdBreakRendererAdapter
- (BOOL)isPreroll {
  HBLogDebug(@"YTAdBreakRendererAdapter isPreroll");
  return false;
}
%end

%hook YTPromotedVideoCellController
- (BOOL)shouldShowPromotedItems {
  HBLogDebug(@"YTPromotedVideoCellController shouldShowPromotedItems");
  return false;
}
%end

%hook YTVideoAdsController
+ (BOOL)isAdSenseAdTag:(id)arg1 {
  HBLogDebug(@"YTVideoAdsController isAdSenseAdTag: %@", arg1);
  return false;
}
%end

%hook YTVASTAd
- (BOOL)isForecastingAd {
  HBLogDebug(@"YTVASTAd isForecastingAd");
  return false;
}
%end

%hook YTPlayerViewController
- (BOOL)isPlayingAd {
  HBLogDebug(@"YTPlayerViewController isPlayingAd");
  return false;
}
%end

%hook YTIPlayerResponse
- (BOOL)isMonetized {
  HBLogDebug(@"YTIPlayerResponse isMonetized");
  return false;
}
%end

%hook YTPlaybackData
- (BOOL)isPlayableInBackground {
  HBLogDebug(@"YTPlaybackData isPlayableInBackground");
  return true;
}
%end

%hook YTFeaturedWatermarkView
- (void)updateWatermarkSizeWithHeight:(unsigned long long)arg1 {
  HBLogDebug(@"YTFeaturedWatermarkView updateWatermarkSizeWithHeight");
  %orig(0);
}
%end

%hook YTReachabilityController
%end

%hook YTUserDefaults
%end

%hook YTSettings
- (void)setAdultContentConfirmed:(BOOL)arg1 {
  HBLogDebug(@"YTSettings setAdultContentConfirmed");
  %orig(false);
}
- (void)setControversialContentConfirmed:(BOOL)arg1 {
  HBLogDebug(@"YTSettings setControversialContentConfirmed");
  %orig(false);
}
- (BOOL)isAdultContentConfirmed {
  HBLogDebug(@"YTSettings isAdultContentConfirmed");
  return false;
}
- (BOOL)isControversialContentConfirmed {
  HBLogDebug(@"YTSettings isControversialContentConfirmed");
  return false;
}
- (BOOL)isFullVersionEnabled {
  HBLogDebug(@"YTSettings isFullVersionEnabled");
  return true;
}
- (BOOL)enableSSOSFSafari {
  HBLogDebug(@"YTSettings enableSSOSFSafari");
  return true;
}
%end

%hook YTVideo
- (BOOL)isAdultContent {
  HBLogDebug(@"YTVideo isAdultContent");
  return false;
}
- (BOOL)isPrivateContent {
  HBLogDebug(@"YTVideo isPrivateContent");
  return false;
}
- (BOOL)isPaidContent {
  HBLogDebug(@"YTVideo isPaidContent");
  return false;
}
%end

%hook YTDataUtils
+ (BOOL)isAdvertisingTrackingEnabled {
  HBLogDebug(@"YTDataUtils isAdvertisingTrackingEnabled");
  return false;
}
%end

