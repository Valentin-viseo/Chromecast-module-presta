const context = cast.framework.CastReceiverContext.getInstance ();
const playerManager = context.getPlayerManager ();

// Listen and log all Core Events.
playerManager.addEventListener (cast.framework.events.category.CORE, event => {
  console.log ('Core event: ' + event.type);
  console.log (event);
});

playerManager.addEventListener (
  cast.framework.events.EventType.MEDIA_STATUS,
  event => {
    console.log ('MEDIA_STATUS event: ' + event.type);
    console.log (event);
  }
);

// Intercept the LOAD request to be able to read in a contentId and get data.
playerManager.setMessageInterceptor (
  cast.framework.messages.MessageType.LOAD,
  loadRequestData => {
    return loadRequestData;
  }
);

playerManager.setMessageInterceptor (
  cast.framework.messages.MessageType.PLAY,
  loadRequestData => {
    return loadRequestData;
  }
);

context.addEventListener (cast.framework.system.EventType.READY, () => {
  const deviceCapabilities = context.getDeviceCapabilities ();
  if (
    deviceCapabilities &&
    deviceCapabilities[
      cast.framework.system.DeviceCapabilities.IS_HDR_SUPPORTED
    ]
  ) {
    // Write your own event handling code, for example
    // using the deviceCapabilities[cast.framework.system.DeviceCapabilities.IS_HDR_SUPPORTED] value
  }
  if (
    deviceCapabilities &&
    deviceCapabilities[cast.framework.system.DeviceCapabilities.IS_DV_SUPPORTED]
  ) {
    // Write your own event handling code, for example
    // using the deviceCapabilities[cast.framework.system.DeviceCapabilities.IS_DV_SUPPORTED] value
  }
});
context.start ();

const playbackConfig = new cast.framework.PlaybackConfig ();

// Set the player to start playback as soon as there are five seconds of
// media content buffered. Default is 10.
playbackConfig.autoResumeDuration = 5;

// Set the available buttons in the UI controls.
const controls = cast.framework.ui.Controls.getInstance ();
controls.clearDefaultSlotAssignments ();

// Assign buttons to control slots.
controls.assignButton (
  cast.framework.ui.ControlsSlot.SLOT_1,
  cast.framework.ui.ControlsButton.QUEUE_PREV
);
controls.assignButton (
  cast.framework.ui.ControlsSlot.SLOT_2,
  cast.framework.ui.ControlsButton.CAPTIONS
);
controls.assignButton (
  cast.framework.ui.ControlsSlot.SLOT_3,
  cast.framework.ui.ControlsButton.SEEK_FORWARD_15
);
controls.assignButton (
  cast.framework.ui.ControlsSlot.SLOT_4,
  cast.framework.ui.ControlsButton.QUEUE_NEXT
);
