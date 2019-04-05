window['__onGCastApiAvailable'] = function (isAvailable) {
  if (isAvailable) {
    initializeCastApi ();
  }
};

const applicationId = chrome.cast.media.DEFAULT_MEDIA_RECEIVER_APP_ID;

const initializeCastApi = () => {
  cast.framework.CastContext.getInstance ().setOptions ({
    receiverApplicationId: applicationId,
    autoJoinPolicy: chrome.cast.AutoJoinPolicy.ORIGIN_SCOPED,
  });
};

/* sessionRequest = chrome.cast.SessionRequest (
  applicationId,
  chrome.cast.Capability.VIDEO_OUT,
  1000
); */
console.log (cast.framwork.CastContext.getInstance ());

const getSession = () => {
  const castSession = cast.framework.CastContext
    .getInstance ()
    .getCurrentSession ();
};

const getState = () => {
  const castState = cast.framework.CastContext
    .getInstance ()
    .getSessionState ();
};

const controls = () => {
  const remotePlayer = new cast.framework.RemotePlayer ();
  remotePlayer.canControlVolume = true;
  remotePlayer.canPause = true;
  remotePlayer.canSeek = true;
  const remotePlayerController = new cast.framework.remotePlayerController (
    remotePlayer
  );
  remotePlayerController.addEventListener (
    remotePlayer.RemotePlayerEventType.IS_PAUSED_CHANGED,
    () => {
      if (remotePlayer.isPaused) {
        remotePlayerController.playOrPause ();
        document.getElementById ('playpause').innerHTML = 'Play';
      } else {
        remotePlayerController.playOrPause ();
        document.getElementById ('playpause').innerHTML = 'Pause';
      }
    }
  );

  remotePlayerController.addEventListener (
    remotePlayer.RemotePlayerEventType.IS_MUTED_CHANGED,
    () => {
      if (remotePlayer.isMuted) {
        remotePlayerController.muteOrUnmute ();
        document.getElementById ('muteunmute').innerHTML = 'Unmute';
      } else {
        remotePlayerController.muteOrUnmute ();
        document.getElementById ('muteunmute').innerHTML = 'Mute';
      }
    }
  );
};

const seekVideoPosition = newPosition => {
  remotePlayer.currentTime = newPosition;
  remotePlayerController.seek () ();
};

const changeVolume = newVolume => {
  remotePlayer.volumeLevel = newVolume;
  remotePlayerController.setVolume ();
};

const launchingMedia = currentMediaUrl => {
  const castSession = cast.framework.CastContext
    .getInstance ()
    .getCurrentSession ();
  let mediaInfo = new chrome.cast.media.MediaInfo (
    currentMediaURL,
    contentType
  );
  let request = new chrome.cast.LoadRequest (mediaInfo);
  castSession.loadMedia (request).then (
    () => {
      console.log ('Media Loaded');
    },
    error => {
      console.log ('error');
    }
  );
};

const stopCasting = () => {
  let castSession = cast.framework.CastContext
    .getInstance ()
    .getCurrentSession ();
  castSession.endSession (true);
};
