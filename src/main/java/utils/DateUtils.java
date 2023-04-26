package utils;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {
    private static final SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-mm-dd");

    public static Timestamp convertToTimestamp(String dateString) throws ParseException {
        Date date = dateFormatter.parse(dateString);
        return new Timestamp(date.getTime());
    }
}