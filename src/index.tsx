import { useState, useEffect } from 'react';
import { AppState, DeviceEventEmitter } from 'react-native';

let backgroundTimeout: Timeout;

export type LockAppStateStatus =
  | 'active'
  | 'background'
  | 'inactive'
  | 'unknown'
  | 'extension'
  | 'screenLock'
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
    const onLockListener = DeviceEventEmitter.addListener(
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
