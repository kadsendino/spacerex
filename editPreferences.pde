//vv general use vv
public String[] getList(String list){ //owned_upgrades, equipped_upgrades, settings
  return split(sharedPreferences.getString(list, ""), ",");
}

public void addToList(String list, String value){ //owned_upgrades, equipped_upgrades
  //this also sorts the list!
  String temp = sharedPreferences.getString(list, "");
  temp += value;
  String[] temp_sort = split(temp, ",");
  temp_sort.sort();

  saveList(list, temp_sort);
}

public void saveList(String name, String[] list){
  String ret_temp = "";
  for(int i=0; i<list.length; i++){
    if(list[i] != null){
      ret_temp += list[i];
    }
  }
  SharedPreferences.Editor editor = sharedPreferences.edit();
  editor.String(name, ret_temp);
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
      String[] pieces = split(reader.readLine(), ", ");
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
      addToList("equipped_upgrades", id);
      return;
    }
  }
  //todo handle id not being in list
}
public void unEquipUpgrade(String id){
  String[] upgrades_temp = getList("equiped_upgrades");
  for(int i=0; i<upgrades_temp.length; i++){
    if(id.equals(upgrades_temp[i])){
      upgrades_temp[i] = null;
      saveList("equiped_upgrades", upgrades_temp);
    }
  }
  //todo handle id not being in list
}
public void clearPlayerInventory(){
  SharedPreferences.Editor editor = sharedPreferences.edit();
  editor.putString("owned_upgrades", "");
  editor.putString("equipped_upgrades", "");
  editor.commit();
}
