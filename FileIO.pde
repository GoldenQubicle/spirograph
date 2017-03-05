class FileIO {
  String JSON = "C:\\Users\\Erik\\Documents\\Processing\\sprgphv2\\data\\testSave.json";
  JSONObject currentFile;
  JSONArray colorBackground;
  String [] globals = {"gifWidth", "gifHeight", "gifLength", "gifInterval", "colorBackground"};


  FileIO() {
    currentFile = new JSONObject();
    currentFile.setInt(globals[0], Width);
    currentFile.setInt(globals[1], Height);
    currentFile.setFloat(globals[2], 4000);
    currentFile.setFloat(globals[3], 12);
    currentFile.setInt(globals[4], cBackground);
    colorBackground = new JSONArray();
    //for (int i = 0; i < 3; i++) {
    //  colorBackground.setInt(i, 128);
    //}
    //currentFile.setJSONArray("colorBackground", colorBackground);
  }

  void saveAs() {
    currentFile.setInt(globals[0], Width);
    currentFile.setInt(globals[1], Height);
    currentFile.setFloat(globals[2], gif.totalTime);
    currentFile.setFloat(globals[3], gif.Interval);
    currentFile.setInt(globals[4], cBackground);
    saveJSONObject(currentFile, JSON);
  }

  void loadGif() {
    currentFile = loadJSONObject(JSON);
  }
}