# react-native-lock-appstate

Detection background and screen lock

## Installation

```sh
npm install react-native-lock-appstate
```

## Usage

```js
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
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
