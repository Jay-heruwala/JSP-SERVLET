package DAO;

import java.sql.*;
import java.util.*;
import Util.DatabaseUtil;
import Entity.Medicine;
import java.text.SimpleDateFormat;

public class MedicineDAO {

    private Connection connection;

    public MedicineDAO() {
        connection = DatabaseUtil.getConnection();
    }

    public List<Medicine> getAllMedicines() {
        List<Medicine> medicines = new ArrayList<>();

        try {
            String sql = "select * from medicines";
            PreparedStatement psmt = connection.prepareStatement(sql);
            ResultSet rs = psmt.executeQuery();

            while (rs.next()) {
                Medicine medicine = new Medicine();
                medicine.setId(rs.getInt(1));
                medicine.setMedicineName(rs.getString(2));
                medicine.setMedicineDetail(rs.getString(3));
                medicine.setManufacturerName(rs.getString(4));
                medicine.setBatchNo(rs.getString(5));
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Adjust format as needed
                medicine.setManufacturingMonthYear(sdf.parse(rs.getString(6)));
                medicine.setExpiryMonthYear(sdf.parse(rs.getString(7)));
                medicines.add(medicine);
            }
        } catch (Exception e) {
            System.out.println("Error : " + e.getMessage());
        }
        System.out.println(medicines.size());
        return medicines;
    }

    public List<Medicine> searchMedicine(String searchPattern) throws SQLException {
        List<Medicine> medicines = new ArrayList<>();
        try{
        String sql = "select * from medicines where medicine_name like ? or manufacturer_name like ?";
        PreparedStatement psmt = connection.prepareStatement(sql);
        psmt.setString(1, "%" + searchPattern + "%");
        psmt.setString(2, "%" + searchPattern + "%");
        ResultSet rs = psmt.executeQuery();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        while (rs.next()) {
            Medicine medicine = new Medicine();
            medicine.setId(rs.getInt(1));
            medicine.setMedicineName(rs.getString(2));
            medicine.setMedicineDetail(rs.getString(3));
            medicine.setManufacturerName(rs.getString(4));
            medicine.setBatchNo(rs.getString(5));
            medicine.setManufacturingMonthYear(sdf.parse(rs.getString(6)));
            medicine.setExpiryMonthYear(sdf.parse(rs.getString(7)));
            medicines.add(medicine);
        }
        }catch(Exception e){
            System.out.println("Error : " + e.getMessage());
        }
        
        return medicines;
    }

}
