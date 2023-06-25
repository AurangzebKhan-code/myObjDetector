import React, { useState } from 'react';
import { requireNativeComponent, View, Text } from 'react-native';
import PropTypes from 'prop-types';

// Importing the native view component
const CameraManager = requireNativeComponent('CameraManager');

// BoundingBox component for displaying a detected rectangle
const BoundingBox = ({ box }) => {
  // Destructuring the box object
  const { x, y, width, height } = box;

  // Define box style
  const boxStyle = {
    position: 'absolute',
    left: x,
    top: y,
    width,
    height,
    borderWidth: 2,
    borderColor: 'red',
  };

  // Render the bounding box
  return <View style={boxStyle} />;
};

// Prop types for BoundingBox
BoundingBox.propTypes = {
  box: PropTypes.shape({
    x: PropTypes.number.isRequired,
    y: PropTypes.number.isRequired,
    width: PropTypes.number.isRequired,
    height: PropTypes.number.isRequired,
  }).isRequired,
};

// Main camera component
const MyCameraComponent = () => {
  // Initialize state for bounding boxes
  const [boxes, setBoxes] = useState([]);

  // Handler for onBoundingBox events from the camera manager
  const handleBoundingBox = (event) => {
    setBoxes((oldBoxes) => [...oldBoxes, event.nativeEvent]);
  };

  // Render the camera view and detected bounding boxes
  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <CameraManager onBoundingBox={handleBoundingBox} style={{ flex: 1, alignSelf: 'stretch' }} />
      {boxes.map((box, index) => (
        <BoundingBox key={index} box={box} />
      ))}
    </View>
  );
}

export default MyCameraComponent;
