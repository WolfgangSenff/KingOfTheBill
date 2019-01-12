# KingOfTheBill

This game is a demo of a way to implement combo moves in a fighting game. At the moment, it only supports "normal" moves, i.e. one button, sequential ordering. However, I'm in the process of implementing "chargeable" moves, where you have to hold down the button for a certain amount of time before it's complete, and n-button moves, where you have to hit two or more buttons more or less simultaneously. Both of these should be fairly easy to implement.

Some of the known issues:
* Currently, if the amount of time after a move is completed is fairly short, it is possible that a longer move with the same beginning sequence won't be possible to trigger. The recommended fix for that is to increase that amount of time (which you can find as an export on the MoveController.gd script), or to always ensure your combo moves aren't too long. If the amount of time that you increase the value to is too large, it will appear in-game as move lag, similar to how you see the same type of lag on some console games. I suspect they are implemented similarly, if much faster, likely in C++.
* I'm not sure why, but it seems like the amount of time per move that is allowed needs to be surprisingly large. I have attempted to do some testing of this, and have found that moves under 4 seconds can't really be easily registered, at least not with my mechanical keyboard running through a USB hub to my machine.

Fell free to report bugs and such! Happy to take a look.
