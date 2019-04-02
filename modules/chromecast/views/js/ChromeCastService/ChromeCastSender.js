window['__onGCastApiAvailable'] = function (isAvailable) {
  if (isAvailable) {
    initializeCastApi ();
  }
};

const initializeCastApi = () => {
  cast.framework.CastContext.getInstance ().setOptions ({
    receiverApplicationId: applicationId,
    autoJoinPolicy: chrome.cast.AutoJoinPolicy.ORIGIN_SCOPED,
  });
};

sessionRequest = chrome.cast.SessionRequest (
  applicationId,
  chrome.cast.Capability.VIDEO_OUT,
  1000
);
console.log (cast.framwork.CastContext.getInstance ());
const castSession = cast.framework.CastContext
  .getInstance ()
  .getCurrentSession ();
const castState = cast.framework.CastContext.getInstance ().getSessionState ();

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

let mediaInfo = new chrome.cast.media.MediaInfo (currentMediaURL, contentType);
let request = new chrome.cast.LoadRequest (mediaInfo);

const stopCasting = () => {
  let castSession = cast.framework.CastContext
    .getInstance ()
    .getCurrentSession ();
  castSession.endSession (true);
};
