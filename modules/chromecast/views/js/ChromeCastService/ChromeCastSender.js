// class ChromeCastSender {
//   constructor() {
    
//   }
  
//   initializeCastApi = () => {
//     cast.framework.CastContext.getInstance ().setOptions ({
//       receiverApplicationId: chrome.cast.media.DEFAULT_MEDIA_RECEIVER_APP_ID,
//       autoJoinPolicy: chrome.cast.AutoJoinPolicy.ORIGIN_SCOPED,
//     });
//     /// Initialize button to connect to chromeCast
//     // const valuue = document.createElement("google-cast-launcher");
//     // const noWomanNoCry = document.getElementById("noWomanNoCry")
//     // noWomanNoCry.appendChild(valuue)
//     console.log(cast)
//   };

//   noMoreCry = () => {
//     console.log(cast.framework.CastContext.getInstance().getCurrentSession())
//   }
  
//   disconnectFromChromeCast = () => {
//     cast.framework.CastContext.getInstance().getCurrentSession().endSession(true)
//   }
  
//   launchVideo = () => {
//     var castSession = cast.framework.CastContext.getInstance().getCurrentSession();
//     const mediaInfo = new chrome.cast.media.MediaInfo(JUL, "image/gif");
//     const request = new chrome.cast.media.LoadRequest(mediaInfo);
//     castSession.loadMedia(request).then(
//       () => {
//         console.log("link ok")
//       },
//       (errorCode) => {
//         console.log("Error code" + errorCode);
//       })
//   }

// }

// const chromeCastSender = new ChromeCastSender();

// window['__onGCastApiAvailable'] = function (isAvailable) {
//   if (isAvailable) {
//     chromeCastSender.initializeCastApi();
//   }
// };

// const nulnulnul = () => {
//   console.log(nulnulnul)
// }

// var MEDIA_SOURCE_ROOT =
//     'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/';

// const JUL =  "https://media1.tenor.com/images/ed1a440293def059dd5e8be33b7931b7/tenor.gif?itemid=12205924";

// var mediaURLs = [
//   'http://commondatastorage.googleapis.com/gtv-videos-bucket/big_buck_bunny_1080p.mp4',
//   'http://commondatastorage.googleapis.com/gtv-videos-bucket/ED_1280.mp4',
//   'http://commondatastorage.googleapis.com/gtv-videos-bucket/tears_of_steel_1080p.mov',
//   'http://commondatastorage.googleapis.com/gtv-videos-bucket/reel_2012_1280x720.mp4',
//   'http://commondatastorage.googleapis.com/gtv-videos-bucket/Google%20IO%202011%2045%20Min%20Walk%20Out.mp3'];

