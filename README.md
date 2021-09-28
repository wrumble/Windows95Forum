# Windows95Forum

## To Run 

There are no dependencies so download the repo and open the project via `Windows95Forum.xcworkspace` make sure `Windows95Forum` scheme is selected and press play.

Note: This should be fixed and i cant reproduce but leaving it here just in case. I have noticed occasionally and for no apparent reason i can find so far, that xcode sometimes cant find some autogenerated build files for the `ForumClient` module. If these errors show for you

<img width="475" alt="Screenshot 2021-09-27 at 23 31 48" src="https://user-images.githubusercontent.com/17275987/134994263-5909f473-f549-4fa4-b299-2ead1cc5fabd.png">

then the fix is to select `ForumClient` scheme, build it, then go back to the `Windows95Forum` scheme and run the app again, it should work fine. It kills me that this happens and i cant find a fix.

## To Test

With `Windows95Forum` scheme selected pressing `CMD+U` should run all the tests. 
Or you can select each scheme and run their individual tests that way

## Why a Windows 95 Forum

Why not! Honestly i have no idea why i did this i just quite fancied the idea of this being the last windows 95 forum left on the planet.
Plus i wanted to play with how it looked to see how hard it was!

## Architecture
The app is simple an uses the most basic of MVVM architectures, it doesnt even need a router as its only one screen.

I did contemplate the idea of a second screen to show the comments but felt the amount of duplication was too high and unnecessary, so just reloading a tableView was fine.

## What im not sure about

### Combine
My knowledge of combine isnt great, this is the first time ive actually used it so im unsure if its beeen implemented in the best possible way everywhere.

There are a few places where i feel i missed some syntactic sugar so where i am doing this

```
    xButtonTapped
      .sink(receiveValue: { [weak self] _ in
        guard let self = self else {
          return
        }
        self.viewModel.xButtonTapped.send()
      })
      .store(in: &publishers)
```

i would have liked to do some thing like this 

```
xButtonTapped
   .bind(viewModel.xButtonTapped)
   .store(in: &publishers)
```
but i couldnt google enough to see if this was possible.

I would have like to have done similar for binding tap receipts on UIButtons to reactive streams but didnt find that either

The other thing i didnt realise until late was that tableViews are setup to work with combines publishers too. But i feel the current implementation is fine too.

### The rest

`WindowsViewModel`, probably isnt necessary as it stand but it maintains the architecture throughout the app so i decided to leave in as opposed to passing the Subjects directly to the view.

The placement of Post, User and Comment models in model didnt feel right, maybe an entirely seperate module for DTO's is better, but keeping them in the services creates a cyclic dependency between the ForumClient and serv ices so this isnt possible

The custom font caused the tests to fail so they had to default to a system font so a few tests around the cells would run completely

There services being extracted into their own modules may have been too far but i feel it sets a good precedent going forward

Subviewable is the worst name

