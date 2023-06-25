# Custom Camera Component for React Native on iOS
This project provides a custom camera view for a React Native application on iOS. It uses the AVFoundation and Vision frameworks to capture frames from the device's camera, perform rectangle detection on each frame, and render the detected rectangles using a custom overlay. 

 **Installation**

This component is native to iOS and requires linking native dependencies. Please ensure that you have a proper React Native environment set up before proceeding.

If you're using React Native version 0.60 and above, autolinking should take care of the installation process.
* Copy the Swift, Objective-C, and Bridging Header files into your project's ios directory.
* Open your project in Xcode and add these files to your app target.


**Usage**

- Import the component in your JavaScript file: 

import { requireNativeComponent } from 'react-native';
const CameraManager = requireNativeComponent('CameraManager');  

- In your React component, include the CameraManager component and provide a callback function to the onBoundingBox prop:  

<CameraManager onBoundingBox={this.handleBoundingBox} style={{ flex: 1, alignSelf: 'stretch' }} />

-  In your handleBoundingBox function, you can handle the bounding box data received from the event:

  handleBoundingBox = (event) => {
  // Do something with event.nativeEvent
};   

**Note : For detailed documentation please open the file “Documentation_myObjDetectorApp” contained in Documentation folder**
