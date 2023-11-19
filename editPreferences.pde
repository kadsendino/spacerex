//vv general use vv
public String[] getList(String list){ //owned_upgrades, equipped_upgrades, settings
  return split(sharedPreferences.getString(list, ""), ";");
}

public void saveList(String name, String[] list){
  String ret_temp = "";
  for(int i=0; i<list.length; i++){
    if(list[i] != null && !list[i].equals("")){
      if(!ret_temp.equals("")){ //do not put a simecolon at the beginning
        ret_temp += ";";
      }
      ret_temp += list[i];
    }
  }
  SharedPreferences.Editor editor = sharedPreferences.edit();
  editor.putString(name, ret_temp);
  editor.commit();
}

//vv Stats vv
public void updateStat(String stat){ //killedRocks, shotsFired, finishedGames
  SharedPreferences.Editor editor = sharedPreferences.edit();
  editor.putInt(stat, sharedPreferences.getInt(stat, 0)+1);
  editor.commit();
}
public void setStat(String stat, int value){ //highscore
  SharedPreferences.Editor editor = sharedPreferences.edit();
  editor.putInt(stat, value);
  editor.commit();
}
public int getStat(String stat){
  return sharedPreferences.getInt(stat, 0);
}

//vv achievements vv
public boolean TestAchievements(){
  boolean ret = false;
  BufferedReader reader;
  reader = createReader("allAchievements.m1");
  while(true){
    try{
      String[] pieces = split(reader.readLine(), "; ");
      Achievement a = new Achievement(pieces[0], int(pieces[2]), pieces[1]);
      a.test();
      int progress = a.getProgress();
      if(progress > getStat(pieces[0])){ //if progress on achievement is larger than saved progress
        setStat(pieces[0], progress);
        ret = true;
      }
    }
    catch(IOException e){
      break;
    }
    catch(NullPointerException e){
      break;
    }
  }
  return ret;
}

//vv upgrades vv
public void equipUpgrade(String id){
  String[] upgrades_temp = getList("owned_upgrades");
  for(int i=0; i<upgrades_temp.length; i++){
    if(id.equals(upgrades_temp[i])){
      addToString("equipped_upgrades", id);
      upgrades_temp[i] = "";
      saveList("owned_upgrades", upgrades_temp);
      return;
    }
  }
}
public void unEquipUpgrade(String id){
  String[] upgrades_temp = getList("equipped_upgrades");
  for(int i=0; i<upgrades_temp.length; i++){
    if(id.equals(upgrades_temp[i])){
      addToString("owned_upgrades", id);
      upgrades_temp[i] = "";
      saveList("equipped_upgrades", upgrades_temp);
      return;
    }
  }
}
public void clearPlayerInventory(){
  SharedPreferences.Editor editor = sharedPreferences.edit();
  editor.putString("owned_upgrades", "");
  editor.putString("equipped_upgrades", "");
  editor.commit();
}

public void addToString(String list, String item){
  String old = sharedPreferences.getString(list, "");
  if(old.equals("")){
    SharedPreferences.Editor editor = sharedPreferences.edit();
    editor.putString(list, item);
    editor.commit();
  }
  else{
    String newId = split(item, ",")[0];
    int newNum = int(split(item, ",")[1]);
    String[] upgrades_temp = getList(list);
    for(int i=0; i<upgrades_temp.length; i++){
      String tempId = split(upgrades_temp[i], ",")[0];
      int tempNum = int(split(upgrades_temp[i], ",")[1]);
      if(tempId.equals(newId)){
        upgrades_temp[i] = tempId+","+Integer.toString(tempNum+newNum);
        saveList(list, upgrades_temp);
        return;
      }
    }
    SharedPreferences.Editor editor = sharedPreferences.edit();
    editor.putString(list, old+";"+item);
    editor.commit();
  }
}
