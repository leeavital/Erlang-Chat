package main;

public class Main {

	public static void main(String[] args) {
		
		System.out.println("started....");
		
		ClientController controller = new ClientController();
		MainWindow w = new MainWindow( controller );
		
		
		controller.setView(w);
		
	}
}