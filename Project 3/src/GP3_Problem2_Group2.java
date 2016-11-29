import java.sql.*;
import java.util.Scanner;

/**
 * Problem 2 Java Program: Allows user to add performers and print table
 * @author Alex Salazar-Almaraz, Frederick Smeltzer, Danny Ta, Jordan Nguyen
 * @version 1.0
 */
public class GP3_Problem2_Group2 {
    /**
     * URL for connecting to the database
     */
    private static final String URL = "jdbc:oracle:thin:@//oracle.cs.ou.edu:1521/pdborcl.cs.ou.edu";
    /**
     * Prompt for asking user for option selection
     */
    private static final String PROMPT =
                    "-----------------------------------------------------------\n" +
                    "Option 1: Insert performer with: id, name, and age\n" +
                    "Option 2: Insert performer with: id, name, age, and did\n" +
                    "Option 3: Display all performer information\n" +
                    "Option 4: Quit\n" +
                    "\nEnter Option Number: ";

    /**
     * Main program for allowing user input and sending requests to the Oracle DB
     * @param args username and password
     */
    public static void main(String[] args) {
        // Make sure arguments are entered
        if (args.length != 2) {
            System.err.println("Enter arguments: username & password");
            System.exit(1);
        }
        // Load Database Driver
        try {
            Class.forName("oracle.jdbc.OracleDriver");
        } catch (ClassNotFoundException e) {
            System.err.println("Unable to load the driver class");
        }
        // Connect to database and perform operations
        try {
            // Connect to the database
            Connection c = DriverManager.getConnection(URL, args[0], args[1]);

            // initialize basic things
            boolean quit = false;  // Loop exit condition
            Scanner input = new Scanner(System.in);  // User input reader
            String template = "| %3s | %20s | %20s | %3s |";  // Table output format
            Statement s = c.createStatement();  // Query statement
            CallableStatement cs; // Procedure call statement
            ResultSet result;  // Query result


            // Performer Info
            int pid; // Performer ID
            String pname; // Performer Name
            int age;  // Performer Age
            int did;  // Director ID

            // Displays prompt every loop and gets user option
            while (!quit) {
                switch (getNumber(PROMPT, input)) {
                    case 1: // insert performer
                        System.out.println("Option 1 selected: Adding Performer");
                        // Get user input
                        pid = getNumber("Enter Performer ID: ", input);
                        pname = getString("Enter Performer Name: ", input);
                        age = getNumber("Enter Performer Age: ", input);
                        // Make the call statement
                        cs = c.prepareCall("{call gp3_problem2_group2.insertPerformerOption1(?,?,?)}");
                        // Set the information
                        cs.setInt(1, pid);
                        cs.setString(2, pname);
                        cs.setInt(3, age);
                        // Execute and close
                        cs.executeUpdate();
                        cs.close();
                        break;
                    case 2: // insert performer with did
                        System.out.println("Option 2 selected: Adding Performer");
                        // Get user input
                        pid = getNumber("Enter Performer ID: ", input);
                        pname = getString("Enter Performer Name: ", input);
                        age = getNumber("Enter Performer Age: ", input);
                        did = getNumber("Enter Director ID: ", input);
                        // Make the call statement
                        cs = c.prepareCall("{call gp3_problem2_group2.insertPerformerOption2(?,?,?,?)}");
                        // Set the information
                        cs.setInt(1, pid);
                        cs.setString(2, pname);
                        cs.setInt(3, age);
                        cs.setInt(4, did);
                        // Execute and close
                        cs.executeUpdate();
                        cs.close();
                        break;
                    case 3: // Print our performers
                        System.out.println("Option 3 selected.");
                        result = s.executeQuery("SELECT * FROM PERFORMER");
                        // Print table header
                        System.out.println("-----------------------------------------------------------");
                        System.out.println(String.format(template,"PID", "PNAME", "YEARS_OF_EXPERIENCE", "AGE"));
                        System.out.println("-----------------------------------------------------------");
                        // Print row data
                        while (result.next()) {
                            System.out.println(
                                    String.format(template,
                                            result.getString(1),
                                            result.getString(2),
                                            result.getString(3),
                                            result.getString(4)));
                        }
                        break;
                    case 4: // quit the program
                        quit = true;
                        System.out.println("Option 4 selected: Quitting Program. Have a nice day :)");
                        break;
                    default: // invalid input handling
                        System.out.println("Invalid Option");
                        break;
                }
            }

            // clean up
            input.close();
            s.close();
            c.close();

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Something went wrong yo!");
        }
    }

    /**
     * Get number from the user input stream
     * @param prompt the message displayed to user
     * @param s the scanner for receiving input
     * @return int: user input number
     */
    static private int getNumber(String prompt, Scanner s){
        int result = -1;
        // keep asking until valid input is received
        while (result < 0) {
                System.out.print(prompt);
            try {
                result = Integer.parseInt(s.nextLine());
                if (result < 0) {
                    System.out.println("Enter non-negative numbers");
                }
            } catch (NumberFormatException e) {
                System.out.println("Invalid Input");
            }
        }
        return result;
    }

    /**
     * Get String from the user input stream
     * @param prompt the message displayed to the user
     * @param s the scanner for receiving input
     * @return String: user input string
     */
    static private String getString(String prompt, Scanner s) {
        String result = null;
        // keep asking until valid input is received
        while (result == null) {
            System.out.print(prompt);
            result = s.nextLine();
            // Verify input
            if(result.length() > 20) {
                System.out.println("Input too large: Max size is 20");
                result = null;
            }
        }
        return result;
    }
}
