package main;

import java.io.IOException;
import java.io.OutputStream;
import java.net.Socket;
import java.net.SocketAddress;
import java.net.UnknownHostException;
import java.util.Scanner;

public class ClientController {

	private MainWindow view;
	private OutputStream chatOut;
	
	
	public ClientController() {
		
		try {
			final Socket s = new Socket("localhost", 5483);
			chatOut = s.getOutputStream();
		
			Runnable r = new Runnable() {
				
				@Override
				public void run() {
					Scanner scan;
					try {
						scan = new Scanner( s.getInputStream() );
						while(scan.hasNext()){
							String message = scan.nextLine();
							System.out.println("received: " + message);
						}
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					
				}
			};
			
			
			Thread t = new Thread(r);
			t.start();
			
		
			

			
		} catch (UnknownHostException e) {
		} catch (IOException e) {
			System.err.println("could not connect to localhost:5483");
		}
 	
	}
	
	
	public void setView(MainWindow view){
		this.view = view;
	}
	
	public void sendMessage(String message) {
		try {
			chatOut.write(message.getBytes());
		} catch (IOException e) {
			System.err.println("could not send the message : " + e.getMessage());
		}
		
	}

}
