{if isset($html) && $html}
    <div id="log">
    </div>
      {* {$html} *}
    {* </div>  *}
    {* <a onClick="numberone({$html})">
    no women no cry
    </a>  *}
    <a onClick="coucou()"> coucou </a>
    <input type="hidden" id="variableAPasser" value="{$html}"/>
    <input type="hidden" id="jsAPasser" value="{$js}" />
{else}
    World
{/if}

<script>
    const numberone = (variablemoi) => {
        console.log(variablemoi)
    };
    var variableRecuperee = document.getElementById("variableAPasser").value;
    document.getElementById("log").innerHTML = variableRecuperee
    var jsARecuperer = document.getElementById("jsAPasser").value;
    const myScript = document.createElement('script');
    myScript.text = `{literal} /**
 * Cast initialization timer delay
 **/
var CAST_API_INITIALIZATION_DELAY = 1000;
/**
 * Progress bar update timer delay
 **/
var PROGRESS_BAR_UPDATE_DELAY = 1000;
/**
 * Session idle time out in milliseconds
 **/
var SESSION_IDLE_TIMEOUT = 300000;
/**
 * Media source root URL
 **/
var MEDIA_SOURCE_ROOT =
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/';

// Cast icon thumbnail active
var CAST_ICON_THUMB_ACTIVE = 'images/cast_icon_active.png';
// Cast icon thumbnail idle
var CAST_ICON_THUMB_IDLE = 'images/cast_icon_idle.png';
// Cast icon thumbnail warning
var CAST_ICON_THUMB_WARNING = 'images/cast_icon_warning.png';

var currentMediaSession = null;
var currentVolume = 0.5;
var progressFlag = 1;
var mediaCurrentTime = 0;
var session = null;
var storedSession = null;
var mediaURLs = [
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/big_buck_bunny_1080p.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/ED_1280.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/tears_of_steel_1080p.mov',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/reel_2012_1280x720.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/Google%20IO%202011%2045%20Min%20Walk%20Out.mp3'];
var mediaTitles = [
    'Big Buck Bunny',
    'Elephant Dream',
    'Tears of Steel',
    'Reel 2012',
    'Google I/O 2011 Audio'];

var mediaThumbs = [
    'images/BigBuckBunny.jpg',
    'images/ElephantsDream.jpg',
    'images/TearsOfSteel.jpg',
    'images/reel.jpg',
    'images/google-io-2011.jpg'];
var currentMediaURL = mediaURLs[0];
var currentMediaTitle = mediaTitles[0];
var currentMediaThumb = mediaThumbs[0];

var timer = null;
window['__onGCastApiAvailable'] = function(isAvailable) {
  if (isAvailable) {
    initializeCastApi();
  }
};

function initializeCastApi() {
  // default app ID to the default media receiver app
  // optional: you may change it to your own app ID/receiver
  var applicationIDs = [
      chrome.cast.media.DEFAULT_MEDIA_RECEIVER_APP_ID
    ];


  // auto join policy can be one of the following three
  // 1) no auto join
  // 2) same appID, same URL, same tab
  // 3) same appID and same origin URL
  var autoJoinPolicyArray = [
      chrome.cast.AutoJoinPolicy.PAGE_SCOPED,
      chrome.cast.AutoJoinPolicy.TAB_AND_ORIGIN_SCOPED,
      chrome.cast.AutoJoinPolicy.ORIGIN_SCOPED
    ];

  // request session
  var sessionRequest = new chrome.cast.SessionRequest(applicationIDs[0]);
  var apiConfig = new chrome.cast.ApiConfig(sessionRequest,
    sessionListener,
    receiverListener,
    autoJoinPolicyArray[1]);

  chrome.cast.initialize(apiConfig, onInitSuccess, onError);
}

function onInitSuccess() {
  appendMessage('init success');

  // check if a session ID is saved into localStorage
  storedSession = JSON.parse(localStorage.getItem('storedSession'));
  if (storedSession) {
    var dateString = storedSession.timestamp;
    var now = new Date().getTime();

    if (now - dateString < SESSION_IDLE_TIMEOUT) {
      document.getElementById('joinsessionbyid').style.display = 'block';
    }
  }
}

function onError(e) {
  console.log('Error' + e);
  appendMessage('Error' + e);
}

function onSuccess(message) {
  console.log(message);
}

function onStopAppSuccess() {
  console.log('Session stopped');
  appendMessage('Session stopped');
  document.getElementById('casticon').src = CAST_ICON_THUMB_IDLE;
}

function sessionListener(e) {
  console.log('New session ID: ' + e.sessionId);
  appendMessage('New session ID:' + e.sessionId);
  session = e;
  document.getElementById('casticon').src = CAST_ICON_THUMB_ACTIVE;
  if (session.media.length != 0) {
    appendMessage(
        'Found ' + session.media.length + ' existing media sessions.');
    onMediaDiscovered('sessionListener', session.media[0]);
  }
  session.addMediaListener(
    onMediaDiscovered.bind(this, 'addMediaListener'));
  session.addUpdateListener(sessionUpdateListener.bind(this));
  // disable join by session id when auto join already
  if (storedSession) {
    document.getElementById('joinsessionbyid').style.display = 'none';
  }
}

function sessionUpdateListener(isAlive) {
  if (!isAlive) {
    session = null;
    document.getElementById('casticon').src = CAST_ICON_THUMB_IDLE;
    var playpauseresume = document.getElementById('playpauseresume');
    playpauseresume.innerHTML = 'Play';
    if (timer) {
      clearInterval(timer);
    }
    else {
      timer = setInterval(updateCurrentTime.bind(this),
          PROGRESS_BAR_UPDATE_DELAY);
      playpauseresume.innerHTML = 'Pause';
    }
  }
}

function receiverListener(e) {
  if (e === 'available') {
    console.log('receiver found');
    appendMessage('receiver found');
  }
  else {
    console.log('receiver list empty');
    appendMessage('receiver list empty');
  }
}

function selectMedia(m) {
  console.log('media selected' + m);
  appendMessage('media selected' + m);
  currentMediaURL = mediaURLs[m];
  currentMediaTitle = mediaTitles[m];
  currentMediaThumb = mediaThumbs[m];
  var playpauseresume = document.getElementById('playpauseresume');
  document.getElementById('thumb').src = MEDIA_SOURCE_ROOT + mediaThumbs[m];
}

function launchApp() {
  console.log('launching app...');
  appendMessage('launching app...');
  chrome.cast.requestSession(onRequestSessionSuccess, onLaunchError);
  if (timer) {
    clearInterval(timer);
  }
}

function onRequestSessionSuccess(e) {
  console.log('session success: ' + e.sessionId);
  appendMessage('session success: ' + e.sessionId);
  saveSessionID(e.sessionId);
  session = e;
  document.getElementById('casticon').src = CAST_ICON_THUMB_ACTIVE;
  session.addUpdateListener(sessionUpdateListener.bind(this));
  if (session.media.length != 0) {
    onMediaDiscovered('onRequestSession', session.media[0]);
  }
  session.addMediaListener(
    onMediaDiscovered.bind(this, 'addMediaListener'));
}

function onLaunchError() {
  console.log('launch error');
  appendMessage('launch error');
}

function saveSessionID(sessionId) {
  // Check browser support of localStorage
  if (typeof(Storage) != 'undefined') {
    // Store sessionId and timestamp into an object
    var object = {id: sessionId, timestamp: new Date().getTime()};
    localStorage.setItem('storedSession', JSON.stringify(object));
  }
}

function joinSessionBySessionId() {
  if (storedSession) {
    appendMessage(
        'Found stored session id: ' + storedSession.id);
    chrome.cast.requestSessionById(storedSession.id);
  }
}

function stopApp() {
  session.stop(onStopAppSuccess, onError);
  if (timer) {
    clearInterval(timer);
  }
}

function loadCustomMedia() {
  var customMediaURL = document.getElementById('customMediaURL').value;
  if (customMediaURL.length > 0) {
    loadMedia(customMediaURL);
  }
}

function loadMedia(mediaURL) {
  if (!session) {
    console.log('no session');
    appendMessage('no session');
    return;
  }

  if (mediaURL) {
    var mediaInfo = new chrome.cast.media.MediaInfo(mediaURL);
    currentMediaTitle = 'custom title needed';
    currentMediaThumb = 'images/video_icon.png';
    document.getElementById('thumb').src = MEDIA_SOURCE_ROOT +
        currentMediaThumb;
  }
  else {
    console.log('loading...' + currentMediaURL);
    appendMessage('loading...' + currentMediaURL);
    var mediaInfo = new chrome.cast.media.MediaInfo(currentMediaURL);
  }
  mediaInfo.metadata = new chrome.cast.media.GenericMediaMetadata();
  mediaInfo.metadata.metadataType = chrome.cast.media.MetadataType.GENERIC;
  mediaInfo.contentType = 'video/mp4';

  mediaInfo.metadata.title = currentMediaTitle;
  mediaInfo.metadata.images = [{'url': MEDIA_SOURCE_ROOT + currentMediaThumb}];

  var request = new chrome.cast.media.LoadRequest(mediaInfo);
  request.autoplay = true;
  request.currentTime = 0;

  session.loadMedia(request,
    onMediaDiscovered.bind(this, 'loadMedia'),
    onMediaError);

}

function onMediaDiscovered(how, mediaSession) {
  console.log('new media session ID:' + mediaSession.mediaSessionId);
  appendMessage('new media session ID:' + mediaSession.mediaSessionId +
      ' (' + how + ')');
  currentMediaSession = mediaSession;
  currentMediaSession.addUpdateListener(onMediaStatusUpdate);
  mediaCurrentTime = currentMediaSession.currentTime;
  playpauseresume.innerHTML = 'Play';
  document.getElementById('casticon').src = CAST_ICON_THUMB_ACTIVE;
  document.getElementById('playerstate').innerHTML =
      currentMediaSession.playerState;
  if (!timer) {
    timer = setInterval(updateCurrentTime.bind(this),
        PROGRESS_BAR_UPDATE_DELAY);
    playpauseresume.innerHTML = 'Pause';
  }
}

/**
 * callback on media loading error
 * @param {Object} e A non-null media object
 */
function onMediaError(e) {
  console.log('media error');
  appendMessage('media error');
  document.getElementById('casticon').src = CAST_ICON_THUMB_WARNING;
}


{/literal}
`
    document.body.appendChild(myScript);
</script>