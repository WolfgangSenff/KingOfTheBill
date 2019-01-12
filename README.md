# KingOfTheBill

This game is a demo of a way to implement combo moves in a fighting game. At the moment, it only supports "normal" moves, i.e. one button, sequential ordering. However, I'm in the process of implementing "chargeable" moves, where you have to hold down the button for a certain amount of time before it's complete, and n-button moves, where you have to hit two or more buttons more or less simultaneously. Both of these should be fairly easy to implement.

Some of the known issues:
* Currently, if the amount of time after a move is completed is fairly short, it is possible that a longer move with the same beginning sequence won't be possible to trigger. The recommended fix for that is to increase that amount of time (which you can find as an export on the MoveController.gd script), or to always ensure your combo moves aren't too long. If the amount of time that you increase the value to is too large, it will appear in-game as move lag, similar to how you see the same type of lag on some console games. I suspect they are implemented similarly, if much faster, likely in C++.
* I'm not sure why, but it seems like the amount of time per move that is allowed needs to be surprisingly large. I have attempted to do some testing of this, and have found that moves under 4 seconds can't really be easily registered, at least not with my mechanical keyboard running through a USB hub to my machine.

Here's the approach I decided on:

1) Make it Godoughy by using nodes and scripts and signals
2) Have the ability to map to the InputMap from the editor
3) Have a top-level "controller" node/script that is looking to see what moves can possibly be made out of the current set of actions; if there are multiple, take the move that has the longest set of actions, to maximize player attack strength (presumably longer actions == harder move == higher power)
4) Have a move script that defines the animation that gets played when the move is executed, as well as the name (this would handle any other data you want as well), as well as the total time you are allowed to execute the move in. Generally, for longer lists, you'll want to make this number higher. I did not use an average value for every action and then take the total actions and multiply by that number, but that's definitely not a bad approach; I just thought it might be fun to be able to make certain moves harder by tweaking the time manually.
5) Have an action script that gives the input action (e.g. ui_left)
6) Have your move controller node/script with move nodes/scripts under it, with action nodes/scripts under that. This hierarchical approach embeds the dictionaries straight into Godot units and allows you to reason (in my opinion) about what's happening way more easily, especially since you have simple places to put breakpoints/print statements if needed.

Feel free to report bugs and such! Happy to take a look.
