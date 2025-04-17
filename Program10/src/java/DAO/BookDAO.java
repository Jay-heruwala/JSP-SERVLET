package DAO;

import java.sql.*;
import Entity.Book;
import Util.DatabaseUtil;

import org.apache.naming.java.javaURLContextFactory;

public class BookDAO {

    private Connection connection;

    public BookDAO() {
        connection = DatabaseUtil.getConnection();
    }

    public boolean addBookInfo(Book book) {
        String sql = "Insert into Book(title,author,price,qty,isbn,publisher,edition_year,catalogue_id) values(?,?,?,?,?,?,?,?)";

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, book.getTitle());
            preparedStatement.setString(2, book.getAuthor());
            preparedStatement.setDouble(3, book.getPrice());
            preparedStatement.setInt(4, book.getQty());
            preparedStatement.setString(5, book.getISBN());
            preparedStatement.setString(6, book.getPublisher());
            preparedStatement.setString(7, book.getEditionYear());
            preparedStatement.setString(8, book.getCataLogID());
            preparedStatement.execute();
            return true;

        } catch (Exception e) {
            return false;
        }
    }

    public boolean deleteBook(int book_id) {

        try {
            String sql = "delete from book where book_id=?";
            PreparedStatement psmt = connection.prepareStatement(sql);
            psmt.setInt(1, book_id);
            psmt.executeUpdate();
            return true;
        } catch (Exception e) {
            return false;
        }

    }

    public Book fetchBook(int book_id) {
        Book book= null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select * from book where book_id = ?");
            preparedStatement.setInt(1, book_id);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                book = new Book();
                book.setBookID(rs.getInt(1));
                book.setTitle(rs.getString(2));
                book.setAuthor(rs.getString(3));
                book.setPrice(rs.getDouble(4));
                book.setQty(rs.getInt(5));
                book.setISBN(rs.getString(6));
                book.setPublisher(rs.getString(7));
                book.setEditionYear(rs.getString(8));
                book.setCataLogID(rs.getString(9));
                return book;
            }

        } catch (Exception e) {
            return null;
        }
        return book;
    }
    
    
     public boolean updateBook(int book_id, String title, String author, double price, int qty, String isbn, String publisher, String edition_year, String catalogue_id) throws SQLException {
        String sql = "update book set title=?,author=?,price=?,qty=?,isbn=?,publisher=?,edition_year=?,catalogue_id=? where book_id=?";
        PreparedStatement psmt = connection.prepareStatement(sql);
        psmt.setString(1, title);
        psmt.setString(2, author);
        psmt.setDouble(3, price);
        psmt.setInt(4, qty);
        psmt.setString(5, isbn);
        psmt.setString(6, publisher);
        psmt.setString(7, edition_year);
        psmt.setString(8, catalogue_id);
        psmt.setInt(9, book_id);
        psmt.executeUpdate();
        return true;
    }

}
