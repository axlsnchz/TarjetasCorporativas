package com.example.tarjetascorporativas;

import com.example.tarjetascorporativas.utils.SQLConnector;
import org.junit.jupiter.api.Test;
import java.sql.Connection;
import static org.junit.jupiter.api.Assertions.*;

public class SQLConnectorTest {

    @Test
    public void testGetConnection() {
        assertDoesNotThrow(() -> {
            try (Connection conn = SQLConnector.getConnection()) {
                assertNotNull(conn);
                assertFalse(conn.isClosed());
                System.out.println("Conexión exitosa a la base de datos Oracle Cloud!");
            }
        });
    }
}
