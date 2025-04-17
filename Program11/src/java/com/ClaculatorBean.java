package com;

public class ClaculatorBean {

    private double operand1;
    private double operand2;
    private String operation;
    private double result;

    public void setOperand1(double operand1) {
        this.operand1 = operand1;
    }

    public void setOperand2(double operand2) {
        this.operand2 = operand2;
    }

    public void setOperation(String operation) {
        this.operation = operation;
    }

    public double getResult() {
        return result;
    }

    public void calculate() {
        switch (operation) {

            case "add":
                result = operand1 + operand2;
                break;
            case "sub":
                result = operand1 - operand2;
                break;
            case "mul":
                result = operand1 * operand2;
                break;
            case "div":
                if (operand2 != 0) {
                    result = operand1 / operand2;
                } else {
                    result = Double.NaN; // Handle division by zero
                }
                break;
            default:
                throw new AssertionError();
        }
    }

}
