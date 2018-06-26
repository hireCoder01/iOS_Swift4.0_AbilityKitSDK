import Foundation

class TriggerHandler {
  func fetchTriggers(forCompletiton completion: (([Trigger])?, Error?) -> Void) {
    let swipeInTrigger = Trigger()
    swipeInTrigger.triggerId = "JQG_SWIPE_IN"
    swipeInTrigger.triggerName = "Brush In"
    swipeInTrigger.triggerIcon = "brushIn"
    swipeInTrigger.triggerType = "user"
    
    let doubleTapTrigger = Trigger()
    doubleTapTrigger.triggerId = "JQG_DOUBLE_TAP"
    doubleTapTrigger.triggerName = "Double Tap"
    doubleTapTrigger.triggerIcon = "doubleTap"
    doubleTapTrigger.triggerType = "user"
    
    
    let swipeOutTrigger = Trigger()
    swipeOutTrigger.triggerId = "JQG_SWIPE_OUT"
    swipeOutTrigger.triggerName = "Brush Out"
    swipeOutTrigger.triggerIcon = "brushOut"
    swipeOutTrigger.triggerType = "user"

    let lightTrigger = Trigger()
    lightTrigger.triggerId = "JQG_NOTIFICATION_WHITE"
    lightTrigger.triggerName = "Snap Tag"
    lightTrigger.triggerIcon = "light"
    lightTrigger.triggerType = "notification"

    let coverTrigger = Trigger()
    coverTrigger.triggerId = "JQG_SHORT_COVER"
    coverTrigger.triggerName = "Cover"
    coverTrigger.triggerIcon = "cover"
    coverTrigger.triggerType = "system"

    completion([swipeInTrigger, doubleTapTrigger, swipeOutTrigger, lightTrigger, coverTrigger], nil)
  }
}
