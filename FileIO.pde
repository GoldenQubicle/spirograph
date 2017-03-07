class FileIO {
  String path = "C:\\Users\\Erik\\Documents\\Processing\\sprgphv2\\data\\";
  String fileName = "";
  JSONObject global, layer, gears;
  String[] globals = {"gifWidth", "gifHeight", "gifLength", "gifInterval", "colorBackground"};
  String [] Gears = {"Gear 0", "Gear 1", "Gear 2", "Gear 3"};

  File folder = new File(path);
  File[] listOfFiles = folder.listFiles();

  FileIO() {
    global = new JSONObject();
    layer = new JSONObject();
    gears = new JSONObject();
  }

  JSONObject saveLayer() {
    // so in here I also, later, want to iterate over layerFrames
    int index = 0;    
    layer.setString("name", layers.get(index).name);
    layer.setInt("id", layers.get(index).id);
    layer.setBoolean("3d", layers.get(index).spheres3d); 
    for (int i = 0; i < layers.get(index).gears.length; i++) {
      gears.setFloat(Gears[i] + " RX", layers.get(index).gears[i].RX);
      gears.setFloat(Gears[i] + " RY", layers.get(index).gears[i].RY);
      gears.setFloat(Gears[i] + " RZ", layers.get(index).gears[i].RZ);
      gears.setFloat(Gears[i] + " Petals", layers.get(index).gears[i].P);
      gears.setFloat(Gears[i] + " Rotate", layers.get(index).gears[i].rotate);
      gears.setFloat(Gears[i] + " Move", layers.get(index).gears[i].speed);
    }; 
    layer.setJSONObject("Gears", gears);      
    layer.setInt("colorFill", layers.get(index).cFill);
    layer.setBoolean("Fill", layers.get(index).fill); 
    layer.setInt("colorStroke", layers.get(index).cStroke);
    layer.setBoolean("Stroke", layers.get(index).stroke);
    layer.setFloat("Line X", layers.get(index).lx);
    layer.setFloat("Line Y", layers.get(index).ly);
    layer.setFloat("strokeWeight", layers.get(index).sw);
    layer.setFloat("density", layers.get(index).density);
    layer.setInt("blendMode", layers.get(index).blendSelect);
    return layer;
  }

  void loadLayer(JSONObject layer) {
    Layer fromJSON = new Layer();
    fromJSON.name = layer.getString("name");
    fromJSON.id = layer.getInt("id");
    fromJSON.spheres3d = layer.getBoolean("3d");
    for (int i = 0; i < fromJSON.gears.length; i++) {
      fromJSON.gears[i].RX = layer.getJSONObject("Gears").getFloat(Gears[i] + " RX"); 
      fromJSON.gears[i].RY = layer.getJSONObject("Gears").getFloat(Gears[i] + " RY");
      fromJSON.gears[i].RZ = layer.getJSONObject("Gears").getFloat(Gears[i] + " RZ");
      fromJSON.gears[i].P = layer.getJSONObject("Gears").getFloat(Gears[i] + " Petals");
      fromJSON.gears[i].rotate = layer.getJSONObject("Gears").getFloat(Gears[i] + " Rotate");
      fromJSON.gears[i].speed = layer.getJSONObject("Gears").getFloat(Gears[i] + " Move");
    }
    fromJSON.cFill = layer.getInt("colorFill");
    fromJSON.fill = layer.getBoolean("Fill");
    fromJSON.cStroke = layer.getInt("colorStroke");
    fromJSON.stroke = layer.getBoolean("Stroke");
    fromJSON.lx = layer.getFloat("Line X");
    fromJSON.ly = layer.getFloat("Line Y"); 
    fromJSON.sw = layer.getFloat("strokeWeight");
    fromJSON.density = layer.getFloat("density");
    fromJSON.blendSelect = layer.getInt("blendMode"); 
    layers.add(fromJSON);
    gui.layerSwitch.addItem(fromJSON.name, fromJSON);
  }


  void loadGif(String filename) { 
    String [] splitName = split(filename, '.');
    fileName = splitName[0];    
    global = loadJSONObject(path + fileName + ".json");
    Width = global.getInt(globals[0]);
    Height = global.getInt(globals[1]);
    gif.totalTime = global.getFloat(globals[2]);
    gif.Interval = global.getFloat(globals[3]);
    cBackground = global.getInt(globals[4]);

    loadLayer(global.getJSONObject("Layer 1"));
  }

  void saveJSON() {
    global.setInt(globals[4], cBackground);
    global.setJSONObject(layers.get(0).name, saveLayer());
    saveJSONObject(global, path + fileName + ".json" );
  }

  void saveAs() {   
    //fileName = filename;
    global.setInt(globals[0], Width);
    global.setInt(globals[1], Height);
    global.setFloat(globals[2], gif.totalTime);
    global.setFloat(globals[3], gif.Interval);
    global.setInt(globals[4], cBackground);
    saveJSONObject(global, path + fileName + ".json");
  }


  File[] getFiles() {
    File folder = new File(path);
    File[] listOfFiles = folder.listFiles();
    return listOfFiles;
  }
}