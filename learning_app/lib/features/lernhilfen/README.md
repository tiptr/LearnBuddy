
I tried this for a while now.  
The Stack is exported from Figma via the Figma to Flutter Plugin :https://www.figma.com/community/plugin/844008530039534144/FigmaToFlutter
However, to get the custom shapes for the button layouts, we need custom clippers. 
Custom Painting would not work 
I found that you get the path of a svg with a svg-to-flutter-converter: https://www.flutterclutter.dev/tools/svg-to-flutter-path-converter/
You upload the svg and get the path which you use to clip the button. 
But I did not get the clipping right so that the Position of the clipped button is shown correctly in the stack.
Ideally, we would have no svg assets and only custom clippings.  

