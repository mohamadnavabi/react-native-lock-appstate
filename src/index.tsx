import { useState, useEffect } from 'react';
import {
  NativeEventEmitter,
  NativeModules,
  Platform,
  AppState,
  DeviceEventEmitter,
} from 'react-native';

let backgroundTimeout: Timeout;

const lockEventEmitter =
  Platform.OS === 'ios'
    ? new NativeEventEmitter(NativeModules.RNEventEmitter)
    : DeviceEventEmitter;

export type LockAppStateStatus =
  | 'active'
  | 'background'
  | 'inactive'
  | 'unknown'
  | 'extension'
  | 'sleepLock'
  | 'buttonLock';

const useAppState = (
  callback?: (state: LockAppStateStatus) => void
): LockAppStateStatus => {
  const [appState, setAppState] = useState<LockAppStateStatus>(
    AppState.currentState
  );

  useEffect(() => {
    const appStateListener = AppState.addEventListener(
      'change',
      onAppStateChange
    );
    const onLockListener = lockEventEmitter.addListener(
      'onLocked',
      onAppStateChange
    );

    return () => {
      appStateListener.remove();
      onLockListener.remove();
    };
  }, [appState]);

  const onAppStateChange = (nextState: LockAppStateStatus) => {
    setAppState(nextState);
    if (callback) callback(nextState);
  };

  return appState;
};

export default useAppState;
