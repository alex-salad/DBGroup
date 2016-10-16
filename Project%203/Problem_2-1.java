package com.company;
import java.sql.*;

public class Main {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        try
        {
            Class.forName("oracle.jdbc.OracleDriver");
        }
        catch (Exception x)
        {
            System.out.println("Alas! I cannot find it! The Driver class! Where?! WHERE?!!!?");
        }

        System.out.print("Enter Login Name: ");
        String id = scanner.nextLine();
        System.out.print("\nEnter Password: ");
        String pass = scanner.nextLine();

        try{
            //The first parameter needs to match where our stuff is.
            Connection.dbConnection=DriverManager.getConnection
                    ("jdbc:oracle:thin:@//oracle.cs.ou.edu:1521/pdborcl.cs.ou.edu", id, pass)
        }
        catch(SQLException x){
            System.out.println("I cannot get the connection! Oh, miserable!");
        }

        //Create statements with a statement object.
        Statement stmt = dbConnection.createStatement();
        //Obtain the average of performer experience whatever.
        ResultSet avgExp = null;
        boolean available = false;
        try{
            ResultSet rs = stmt.executeQuery("SELECT * FROM Performer WHERE age BETWEEN 25 and 45");
            if (rs != null)
                available = true;
        }
        catch (Exception idk){
            System.out.println("No performers between ages 25 and 45.");
        }
        if (available) {
            try {
                avgExp = stmt.executeQuery("SELECT AVG(years_of_experience) FROM Performer WHERE age BETWEEN 25 AND 45");
            } catch (Exception c) {
                System.out.println("Waka waka");
            }
        }
        // If available is false, then years of experience should be 35-18
        try
        {
            if (available) {
                stmt.execute("INSERT INTO Performer VALUES (pname, years_of_experience, age)", ("John Smith", avgExp, 35);
            }
            else
                stmt.execute("INSERT INTO Performer VALUES ('John Smith', 17, 35)");
        }
        catch (Exception o)
        {
            System.out.println("ayyyy");
        }
    }
}
