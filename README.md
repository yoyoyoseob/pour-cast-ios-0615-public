---
tags: XIBs, views, refactoring
languages: objc
---


# pour-cast

Let's refactor this to encapsulate the views! Run the code, it works.

## Instructions

  1. Create an `NSObject` that will encapsulate a name, high temp and low temp for each day.
  2. Create a XIB that will represent a single days label. This XIB should have one external property that is the class you made in step 1
  3. Drop five of those XIBs onto the Storyboard
  4. In the completion Block of the API client, create the day object and pass it into each view you made
