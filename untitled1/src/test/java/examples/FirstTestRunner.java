package examples;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import org.junit.BeforeClass;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class FirstTestRunner {

    @BeforeAll
    public static void before(){
        System.setProperty("karate.env", "default");
    }

    @Test
    void testFirstTest() {
        Results result = Runner.path("classpath:examples").parallel(20);
        assertEquals(0,result.getFailCount(), result.getErrorMessages());

    }

    @Karate.Test
    Karate testFirstEnvTagTest() {
        return Karate.run("firstTest").tags("@env").relativeTo(getClass());
    }

    @Karate.Test
    Karate testFirstDataStoreTagTest() {
        return Karate.run("firstTest").tags("@dataStore").relativeTo(getClass());
    }

}
