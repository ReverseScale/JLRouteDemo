import React, { Component } from 'react';
import { AppRegistry, Text, NativeModules, TouchableHighlight, TouchableOpacity} from 'react-native';

var RNModules = NativeModules.RNOpenNativeMediator;

class SimpleApp extends Component {
  render() {
  	var actionParameter = {
  		text : "原生123sdad"
  	}
  	var pageParameter = {
    	"module"     : "moduleA",
    	"target"      : "ModuleANativePageViewController",
    	"action"  : "setParameterJsonString",
    	"parameter"  : actionParameter
	};
    return (
      <TouchableHighlight onPress={ () => RNModules.RNOpenOneVC(pageParameter)}>
    	<Text>ReactNative 页面文本</Text>
       </TouchableHighlight>
    );
  }
}
AppRegistry.registerComponent('SimpleApp', () => SimpleApp);
