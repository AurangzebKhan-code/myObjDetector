import React, { useState } from 'react';
import { requireNativeComponent, View, Text } from 'react-native';
import PropTypes from 'prop-types';

// Importing the native view component
const CameraManager = requireNativeComponent('CameraManager');

const BoundingBox = ({ box }) => {
  const { x, y, width, height } = box;

  const boxStyle = {
    position: 'absolute',
    left: x,
    top: y,
    width,
    height,
    borderWidth: 2,
    borderColor: 'red',
  };

  return <View style={boxStyle} />;
};

BoundingBox.propTypes = {
  box: PropTypes.shape({
    x: PropTypes.number.isRequired,
    y: PropTypes.number.isRequired,
    width: PropTypes.number.isRequired,
    height: PropTypes.number.isRequired,
  }).isRequired,
};

const MyCameraComponent = () => {
  const [boxes, setBoxes] = useState([]);

  const handleBoundingBox = (event) => {
    setBoxes((oldBoxes) => [...oldBoxes, event.nativeEvent]);
  };

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
