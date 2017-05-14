/*
additional features
- loop playback
- background color to aniMatrix
- radial color 
- density to aniMatrix
- connect gear to aniMatrix
- flexible render, i.e. only changed frames
- save frames in seperate folders
- load frames PImage array upon json load
- render seperate layers, i.e. background layer playback png, foreground realtime
 
KNOW BUGS
- controls freeze when toggling the gear trigs completely off
- aniInterval gui not correct,  off by one error somewhere
- in compiled app controls freeze upon new file save
 
 -------------------------------------------------------------------------------------------------------------------------- 
 ok so couple of long term goals
 when/if Im gonna refactor as outlined below, CurrentState (i.e. Model class) must have a robust update function, i.e.
 have logic functions which work out changes for keyFrames, timing AND Triggers
 - with regard keyFrames, atm storing these in one array, which is really annoying to work with. Moreover, data is already stored in JSON
 so it should be possible to represent keyFrames by simply read/write data directly from JSON, instead of representing it as seperate Layer objects
 - with regard triggers, atm its storing way more data than necessary, i.e. only need active Matrix cells & end values of ani
 
 Obviously, the various render functions in Animation should be consolidated into oneother as the only difference is the value for aniSeek
 Even more obvious: multiple layer support is still not properly implemented . . 
 
 GUI 
 - multiple controller objects and/or groups in seperate functions which can be called by controller to update
 
 Controller
 - receives input and executes commands
 - updates GUI  
 
 CurrentState 
 - add/remove keyframes
 - add/remove time
 - resize surface
 - add/copy/delete layer
 - update triggerArrat
 
 Animation
 - move setupArrays & updateAniMatrixTiming to CurrenState
 - flexible renderLoop, i.e. checks for new/changed triggers (would this check be performed in contoller, and then triggerArray in CurrentState?) 
 - interpolate keyFrames
 - playback over PImage[]
 
 fileIO
 - save/load JSON
 - save PNG
 
 */