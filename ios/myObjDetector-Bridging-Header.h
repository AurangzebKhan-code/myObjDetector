// Bridging_Header.h

// Conditional compiling - this prevents the header from being included more than once, which could cause problems
#ifndef Bridging_Header_h
#define Bridging_Header_h

// Importing React Native's view manager - this allows us to create our own native UI components
#import <React/RCTViewManager.h>

// Importing React Native's bridge module - this allows us to expose our native methods to JavaScript
#import <React/RCTBridgeModule.h>

// End of conditional compiling
#endif /* Bridging_Header_h */
