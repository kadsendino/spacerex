//vv general use vv
public String[] getList(String list){ //owned_upgrades, equipped_upgrades, settings
  return split(sharedPreferences.getString(list, ""), ",");
}

public void addToList(String list, String value){ //list : owned_upgrades, equipped_upgrades
  //this also sorts the list!
  String temp = sharedPreferences.getString(list, ""); //storage string for current inventory
  temp += ","+value; //adds new upgrade to inventory string
  boolean push = false; //new upgrade is not biggest index so the ones afterwoards have to be pushed
  String[] temp_sort = split(temp, ","); //getting single indexes

  for(int i=0; i<temp_sort.length; i++){ //sorting the new element into the Array
    if(!push && temp_sort[i].compareTo(value) > 0){ //if new string belongs to position i for the array to be in order
      push = true;
    }
    if(push){
      String save_temp = temp_sort[i];
      temp_sort[i] = value;
      value = save_temp;
    }
  }
  saveList(list, temp_sort);
}

public void saveList(String name, String[] list){
  String ret_temp = "";
  for(int i=0; i<list.length; i++){
    if(list[i] != null && !list[i].equals("")){
      if(!ret_temp.equals("")){ //do not put a comma at the beginning
        ret_temp += ",";
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
      addToList("equiped_upgrades", id);
      upgrades_temp[i] = "";
      saveList("owned_upgrades", upgrades_temp);
      return;
    }
  }
}
public void unEquipUpgrade(String id){
  String[] upgrades_temp = getList("equiped_upgrades");
  for(int i=0; i<upgrades_temp.length; i++){
    if(id.equals(upgrades_temp[i])){
      addToList("owned_upgrades", id);
      upgrades_temp[i] = "";
      saveList("equiped_upgrades", upgrades_temp);
      return;
    }
  }
}
public void clearPlayerInventory(){
  SharedPreferences.Editor editor = sharedPreferences.edit();
  editor.putString("owned_upgrades", "");
  editor.putString("equiped_upgrades", "");
  editor.commit();
}
