// Getting the username and password
        Scanner input = new Scanner(System.in);
        System.out.print("Username:");
        String username = input.nextLine();
        System.out.print("Password:");
        //the following lines are used to mask the password
        Console console = System.console();
        String password = new String(console.readPassword());
            // create the connection string    
        String connString = "jdbc:oracle:thin:@" + oracleServer + ":1521:"
                + oracleDBName;
 	 public static final String oracleServer = "dbs3.cs.umb.edu";
    // the database name
   	 public static final String oracleDBName = "dbs3";
	
	// Extract the info about the customers
	Statement statement = connection.createStatement();
      ResultSet resultSet = statement.executeQuery("SELECT * FROM Customers");
      while (resultSet.next()) {
        System.out.println("ID: " + resultSet.getInt("cid")
            + ", Name: " + resultSet.getString("name")
            + ", City: " + resultSet.getString("city")
            + ", State: " + resultSet.getString("state")
            + ", Age: " + resultSet.getDouble("age"));
      }

	// id and name of customers with id and title of movies they watched
	resultSet = statement.executeQuery(
          "SELECT Customers.cid, Customers.name, Movies.mid, Movies.title, Watch.watchedon"
          + " FROM Customers"
          + " INNER JOIN Watch"
          + " ON Customers.cid = Watch.cid"
          + " INNER JOIN Movies"
          + " ON Watch.mid = Movies.mid");
      while (resultSet.next()) {
        System.out.println("Customer ID: " + resultSet.getInt("cid")
            + ", Customer Name: " + resultSet.getString("name")
            + ", Movie ID: " + resultSet.getInt("mid")
            + ", Movie Title: " + resultSet.getString("title")
            + ", Watched on: " + resultSet.getDate("watchedon"));
      }
	
	// the number of movies in the database
	resultSet = statement.executeQuery("SELECT COUNT(*) AS movie_count FROM Movies");
      if (resultSet.next()) {
        System.out.println("Number of movies: " + resultSet.getInt("movie_count"));
      }

	// metadata for customers
	resultSet = connection.getMetaData().getTables(null, null, "CUSTOMERS", null);
      while (resultSet.next()) {
        System.out.println("Table: " + resultSet.getString("TABLE_NAME"));
        System.out.println("Type: " + resultSet.getString("TABLE_TYPE"));
        System.out.println("Catalog: " + resultSet.getString("TABLE_CAT"));

	
