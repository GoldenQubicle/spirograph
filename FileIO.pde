class FileIO {
  //String fileName = "default.json";
  String path = "C:\\Users\\Erik\\Documents\\Processing\\sprgphv2\\data\\";
  JSONObject currentFile;
  String[] globals = {"gifWidth", "gifHeight", "gifLength", "gifInterval", "colorBackground"};
  File folder = new File(path);
  File[] listOfFiles = folder.listFiles();

  FileIO() {
    currentFile = new JSONObject();
  }

  void saveAs(String fileName) {
    currentFile.setInt(globals[0], Width);
    currentFile.setInt(globals[1], Height);
    currentFile.setFloat(globals[2], gif.totalTime);
    currentFile.setFloat(globals[3], gif.Interval);
    currentFile.setInt(globals[4], cBackground);
    saveJSONObject(currentFile, path + fileName + ".json");
  }

  void loadGif(String fileName) { 
    currentFile = loadJSONObject(path + fileName);
    Width = currentFile.getInt(globals[0]);
    Height = currentFile.getInt(globals[1]);
    gif.totalTime = currentFile.getFloat(globals[2]);
    gif.Interval = currentFile.getFloat(globals[3]);
    cBackground = currentFile.getInt(globals[4]);
  }

  File[] getFiles() {
    File folder = new File(path);
    File[] listOfFiles = folder.listFiles();
    return listOfFiles;
  }
}