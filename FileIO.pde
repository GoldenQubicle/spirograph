class FileIO {
  String path = "C:\\Users\\Erik\\Documents\\Processing\\sprgphv2\\data\\";
  String fileName = "default";
  JSONObject global, layer, gears, keyFrame;
  JSONArray lkf;
  String[] globals = {"gifWidth", "gifHeight", "gifLength", "gifKeyFrames", "colorBackground", "Layers"};
  String [] Gears = {"Gear 0", "Gear 1", "Gear 2", "Gear 3"};

  File folder = new File(path);
  File[] listOfFiles = folder.listFiles();

  FileIO() {
    global = new JSONObject();
    keyFrame = new JSONObject();
    lkf = new JSONArray();
  }

void saveJSON() {
    global.setInt(globals[0], Width);
    global.setInt(globals[1], Height);
    global.setFloat(globals[2], gif.totalTime);
    global.setFloat(globals[3], gif.keyFrames);
    global.setInt(globals[4], cBackground);
    global.setInt(globals[5], gif.nLayers);
    for (int l = 0; l < gif.nLayers; l++) {
      lkf = new JSONArray();
      global.setJSONArray("Layer "+l, lkf);
      for (int f = 0; f < gif.keyFrames; f++) {
        int keyFrame = f+(l*gif.keyFrames);
        global.getJSONArray("Layer "+l).setJSONObject(f, saveLayer(layerKeyFrames.get(keyFrame)));
      }
    }
    saveJSONObject(global, path + fileName + ".json" );
  }

  JSONObject saveLayer(Layer tobeSaved) {
    layer = new JSONObject();
    gears = new JSONObject();
    layer.setString("name", tobeSaved.name);
    layer.setInt("id", tobeSaved.id);
    layer.setInt("kf", tobeSaved.kf);
    layer.setBoolean("3d", tobeSaved.spheres3d); 
    for (int i = 0; i < tobeSaved.gears.length; i++) {
      gears.setFloat(Gears[i] + " RX", tobeSaved.gears[i].RX);
      gears.setInt(Gears[i] + " trigX", tobeSaved.gears[i].trigX);
      gears.setInt(Gears[i] + " trigX2", tobeSaved.gears[i].trigX2);
      gears.setFloat(Gears[i] + " RY", tobeSaved.gears[i].RY);
      gears.setInt(Gears[i] + " trigY", tobeSaved.gears[i].trigY);
      gears.setInt(Gears[i] + " trigY2", tobeSaved.gears[i].trigY2);
      gears.setFloat(Gears[i] + " RZ", tobeSaved.gears[i].RZ);
      gears.setInt(Gears[i] + " trigZ", tobeSaved.gears[i].trigZ);
      gears.setFloat(Gears[i] + " Petals", tobeSaved.gears[i].P);
      gears.setFloat(Gears[i] + " Rotate", tobeSaved.gears[i].rotate);
      gears.setFloat(Gears[i] + " Move", tobeSaved.gears[i].speed);
    }; 
    layer.setJSONObject("Gears", gears);      
    layer.setInt("colorFill", tobeSaved.cFill);
    layer.setBoolean("Fill", tobeSaved.fill); 
    layer.setInt("colorStroke", tobeSaved.cStroke);
    layer.setBoolean("Stroke", tobeSaved.stroke);
    layer.setFloat("Line X", tobeSaved.lx);
    layer.setFloat("Line Y", tobeSaved.ly);
    layer.setFloat("strokeWeight", tobeSaved.sw);
    layer.setFloat("density", tobeSaved.density);
    layer.setInt("blendMode", tobeSaved.blendSelect);
    return layer;
  }

  Layer loadLayer(JSONObject tobeLoaded) {
    Layer fromJSON = new Layer(100);
    fromJSON.name = tobeLoaded.getString("name");
    fromJSON.id = tobeLoaded.getInt("id");
    fromJSON.kf = tobeLoaded.getInt("kf");
    fromJSON.spheres3d = tobeLoaded.getBoolean("3d");
    for (int i = 0; i < fromJSON.gears.length; i++) {
      fromJSON.gears[i].RX = tobeLoaded.getJSONObject("Gears").getFloat(Gears[i] + " RX"); 
      fromJSON.gears[i].RY = tobeLoaded.getJSONObject("Gears").getFloat(Gears[i] + " RY");
      fromJSON.gears[i].RZ = tobeLoaded.getJSONObject("Gears").getFloat(Gears[i] + " RZ");
      fromJSON.gears[i].P = tobeLoaded.getJSONObject("Gears").getFloat(Gears[i] + " Petals");
      fromJSON.gears[i].rotate = tobeLoaded.getJSONObject("Gears").getFloat(Gears[i] + " Rotate");
      fromJSON.gears[i].speed = tobeLoaded.getJSONObject("Gears").getFloat(Gears[i] + " Move");
      fromJSON.trig.set("G"+i+"trigX", tobeLoaded.getJSONObject("Gears").getInt(Gears[i] + " trigX")); 
      fromJSON.trig.set("G"+i+"trigX2", tobeLoaded.getJSONObject("Gears").getInt(Gears[i] + " trigX2")); 
      fromJSON.trig.set("G"+i+"trigY", tobeLoaded.getJSONObject("Gears").getInt(Gears[i] + " trigY")); 
      fromJSON.trig.set("G"+i+"trigY2", tobeLoaded.getJSONObject("Gears").getInt(Gears[i] + " trigY2"));
      fromJSON.trig.set("G"+i+"trigZ", tobeLoaded.getJSONObject("Gears").getInt(Gears[i] + " trigZ"));
    }
    fromJSON.cFill = tobeLoaded.getInt("colorFill");
    fromJSON.fill = tobeLoaded.getBoolean("Fill");
    fromJSON.cStroke = tobeLoaded.getInt("colorStroke");
    fromJSON.stroke = tobeLoaded.getBoolean("Stroke");
    fromJSON.lx = tobeLoaded.getFloat("Line X");
    fromJSON.ly = tobeLoaded.getFloat("Line Y"); 
    fromJSON.sw = tobeLoaded.getFloat("strokeWeight");
    fromJSON.density = tobeLoaded.getFloat("density");
    fromJSON.blendSelect = tobeLoaded.getInt("blendMode"); 
    return fromJSON;
  }

  void loadJSON(String filename) { 
    String [] splitName = split(filename, '.');
    fileName = splitName[0];    
    global = loadJSONObject(path + fileName + ".json");
    Width = global.getInt(globals[0]);
    Height = global.getInt(globals[1]);
    gif.totalTime = global.getFloat(globals[2]);
    gif.keyFrames = int(global.getFloat(globals[3]));
    gif.nLayers = global.getInt(globals[5]);
    cBackground = global.getInt(globals[4]);
    for (int l =0; l < gif.nLayers; l++) {     
      for (int f=0; f < gif.keyFrames; f++) {     
        layerKeyFrames.add(loadLayer(global.getJSONArray("Layer "+l).getJSONObject(f)));
      }
    }
  }

  File[] getFiles() {
    File folder = new File(path);
    File[] listOfFiles = folder.listFiles();
    return listOfFiles;
  }
}