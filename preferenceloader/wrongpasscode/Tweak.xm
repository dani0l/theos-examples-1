%hook SBDeviceLockController

- (BOOL)attemptDeviceUnlockWithPassword:(NSString *)passcode appRequested:(BOOL)requested {

	NSString *settingsPath = @"/var/mobile/Library/Preferences/com.sassoty.wrongpasscode~prefs.plist";
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];

	BOOL isEnabled = [[prefs objectForKey:@"enabled"] boolValue];

	if(!%orig && isEnabled){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WrongPasscode" message:[NSString stringWithFormat:@"You entered: %@", passcode] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}

	[prefs release];

	return %orig;

}

%end