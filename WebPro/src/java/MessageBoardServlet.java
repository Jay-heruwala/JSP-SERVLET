import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/msgboard")
public class MessageBoardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final List<String> messages = new ArrayList<>();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String message = request.getParameter("message");

        if (name != null && message != null && !name.trim().isEmpty() && !message.trim().isEmpty()) {
            synchronized (messages) {
                messages.add(name + ": " + message);
            }
        }

        request.setAttribute("messages", messages);
        request.getRequestDispatcher("/messageboard.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("messages", messages);
        request.getRequestDispatcher("/messageboard.jsp").forward(request, response);
    }
}