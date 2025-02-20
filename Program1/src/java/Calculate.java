import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Calculate extends HttpServlet {

    public static boolean isDouble(String str) {
        try {
            Double.parseDouble(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public static boolean isInteger(String str) {
        try {
            Integer.parseInt(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher dispatcher;
        String errorMsg = "";

        // Get parameters safely
        String getp = request.getParameter("principalInvestment");
        String getr = request.getParameter("rate");
        String getYear = request.getParameter("year");
        String getMonth = request.getParameter("month");
        String getn = request.getParameter("noOfTimesCompounded");

        getp = (getp != null) ? getp.trim() : "";
        getr = (getr != null) ? getr.trim() : "";
        getYear = (getYear != null) ? getYear.trim() : "";
        getMonth = (getMonth != null) ? getMonth.trim() : "";
        getn = (getn != null) ? getn.trim() : "";

        // Validate inputs
        if (!isDouble(getp)) errorMsg += "Enter a valid amount.<br>";
        if (!isDouble(getr)) errorMsg += "Enter a valid rate.<br>";
        if (!isInteger(getYear)) errorMsg += "Enter a valid year.<br>";
        if (!isInteger(getMonth)) errorMsg += "Enter a valid month.<br>";
        if (!isInteger(getn)) errorMsg += "Select a valid drop value.<br>";
        System.out.println("" + errorMsg);

        if (!errorMsg.isEmpty()) {
            request.setAttribute("valueError", errorMsg);
            dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
            return;  
        }
        
     
        
        

        try {
            // Convert inputs
            double p = Double.parseDouble(getp);
            float r = Float.parseFloat(getr);
            int year = Integer.parseInt(getYear);
            int month = Integer.parseInt(getMonth);
            int n = Integer.parseInt(getn);

            // Range Validation
            if (p < 1 || p > 2000000000) errorMsg += "Principal must be between 1 and 2,000,000,000.<br>";
            if (r < 0.01 || r > 100) errorMsg += "Rate must be between 0 and 100.<br>";
            if (year < 0 || year > 100) errorMsg += "Enter year between 0 and 100.<br>";
            if (month < 0 || month > 12) errorMsg += "Enter month between 0 and 12.<br>";
            if (year == 0 && month == 0) errorMsg += "Enter a valid time period (at least 1 month or 1 year).<br>";

            if (!errorMsg.isEmpty()) {
                request.setAttribute("valueError", errorMsg);
                dispatcher = request.getRequestDispatcher("index.jsp");
                dispatcher.forward(request, response);
                return;  
            }

            // Calculation
            int totalMonths = (year * 12) + month;
            float t = totalMonths / 12.0f;
            double a = p * Math.pow((1 + r / (n * 100)), (n * t));

            // Set attributes and forward
            request.setAttribute("principal", getp);
            request.setAttribute("rate", String.format("%.2f", r));
            request.setAttribute("year", year);
            request.setAttribute("month", month);
            request.setAttribute("interest", String.format("%.2f", (a - p)));
            request.setAttribute("amount", String.format("%.2f", a));

            dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("valueError", "Something went wrong. Please try again.");
            dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        }
    }
}
