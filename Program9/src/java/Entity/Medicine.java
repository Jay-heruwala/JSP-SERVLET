/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

import java.util.Date;

public class Medicine {
    private int id;
    private String medicineName;
    private String medicineDetail;
    private String manufacturerName;
    private String batchNo;
    private Date manufacturingMonthYear;
    private Date expiryMonthYear;

    // Default constructor
    public Medicine() {
    }

    // Parameterized constructor
    public Medicine(int id, String medicineName, String medicineDetail, 
                   String manufacturerName, String batchNo, 
                   Date manufacturingMonthYear, Date expiryMonthYear) {
        this.id = id;
        this.medicineName = medicineName;
        this.medicineDetail = medicineDetail;
        this.manufacturerName = manufacturerName;
        this.batchNo = batchNo;
        this.manufacturingMonthYear = manufacturingMonthYear;
        this.expiryMonthYear = expiryMonthYear;
    }

    // Getter and Setter methods
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMedicineName() {
        return medicineName;
    }

    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }

    public String getMedicineDetail() {
        return medicineDetail;
    }

    public void setMedicineDetail(String medicineDetail) {
        this.medicineDetail = medicineDetail;
    }

    public String getManufacturerName() {
        return manufacturerName;
    }

    public void setManufacturerName(String manufacturerName) {
        this.manufacturerName = manufacturerName;
    }

    public String getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
    }

    public Date getManufacturingMonthYear() {
        return manufacturingMonthYear;
    }

    public void setManufacturingMonthYear(Date manufacturingMonthYear) {
        this.manufacturingMonthYear = manufacturingMonthYear;
    }

    public Date getExpiryMonthYear() {
        return expiryMonthYear;
    }

    public void setExpiryMonthYear(Date expiryMonthYear) {
        this.expiryMonthYear = expiryMonthYear;
    }

    // Optional: toString method for easy printing/logging
    @Override
    public String toString() {
        return "Medicine{" +
                "id=" + id +
                ", medicineName='" + medicineName + '\'' +
                ", medicineDetail='" + medicineDetail + '\'' +
                ", manufacturerName='" + manufacturerName + '\'' +
                ", batchNo='" + batchNo + '\'' +
                ", manufacturingMonthYear=" + manufacturingMonthYear +
                ", expiryMonthYear=" + expiryMonthYear +
                '}';
    }
}