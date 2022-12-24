# react-native-lock-appstate

Detection background and screen lock

## Installation

```sh
npm install react-native-lock-appstate
```

## Usage

```js
import useAppState from 'react-native-lock-appstate';

useAppState((state) => {
  if (state === 'active') {
    // Action if state is actived
  }
  if (state === 'background') {
    // Action if state is background
  }
  if (state === 'sleepLock' || state === 'buttonLock') {
    // Action if state is locked
  }

  // Next states...
});
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
