package examples;

import java.util.HashMap;

public class DataStore {
    public static HashMap<String,Object> data = new HashMap<>();

    public static void putData(String key, Object value){
        data.put(key,value);
    }

    public static Object getData(String key){
        data.get(key);
        return data.get(key);
    }
}
