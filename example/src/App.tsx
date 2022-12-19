import * as React from 'react';
import { StyleSheet, View, Text } from 'react-native';
import useAppState from 'react-native-lock-appstate';

export default function App() {
  const appState = useAppState((state) => {
    if (state === 'active') {
      // Action if state is actived
    }
    if (state === 'background') {
      // Action if state is background
    }
    if (state === 'screenLock' || state === 'buttonLock') {
      // Action if state is locked
    }

    // Next states...
  });

  return (
    <View style={styles.container}>
      <Text>Result: {appState}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
