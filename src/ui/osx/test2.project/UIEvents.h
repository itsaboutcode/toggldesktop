//
//  UIEvents.h
//  kopsik_ui_osx
//
//  Created by Tanel Lebedev on 24/09/2013.
//  Copyright (c) 2013 TogglDesktop developers. All rights reserved.
//

#import <Foundation/Foundation.h>

// States
extern NSString *const kUIStateUserLoggedIn;
extern NSString *const kUIStateUserLoggedOut;
extern NSString *const kUIStateTimerRunning;
extern NSString *const kUIStateTimerStopped;
extern NSString *const kUIStateTimeEntrySelected;
extern NSString *const kUIStateTimeEntryDeselected;
extern NSString *const kUIStateError;
extern NSString *const kUIStateUpdateAvailable;
extern NSString *const kUIStateUpToDate;


// Events
extern NSString *const kUIEventModelChange;
extern NSString *const kUIEventIdleFinished;
extern NSString *const kUIEventSettingsChanged;
extern NSString *const kUIEventShowListView;


// Commands
extern NSString *const kUICommandNew;
extern NSString *const kUICommandStop;
extern NSString *const kUICommandContinue;
extern NSString *const kUICommandShowPreferences;
extern NSString *const kUICommandStopAt;
extern NSString *const kUICommandSplitAt;
extern NSString *const kUICommandEditRunningTimeEntry;

extern NSString *const kUIDurationClicked;
extern NSString *const kUIDescriptionClicked;

extern NSString *const kUIStateOffline;
extern NSString *const kUIStateOnline;


extern float const kThrottleSeconds;