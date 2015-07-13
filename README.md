# Bubbles

First time using Swift :)

Changes for Swift 2:
  - supportedInterfaceOrientations() in ViewController.swift returns UIInterfaceOrientationMask, not Int
  - init(...) in BubbleView.swift needs to be init?(...) -- UIView's init is now failable?
  - println() is now print()? What?!?
  - dispatch_get_global_value(...) takes a QOS as its first argument instead of Int(QOS.value)
  
(Current version is written for Swift 2. I commented out changes for Swift 1.2.)
