package main;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.SpringLayout;
import javax.swing.JTextField;
import javax.swing.JTextArea;
import javax.swing.JButton;
import javax.swing.JPanel;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;

public class MainWindow {

	private JFrame frame;
	private JTextField inputField;
	private JButton sendButton;
	private ClientController controller;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					MainWindow window = new MainWindow();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public MainWindow() {
		initialize();
	}
	
	
	
	public MainWindow( ClientController controller ){
		this.controller = controller;
		initialize();
		
		this.frame.setVisible(true);
		this.frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		this.inputField.requestFocus();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frame = new JFrame();
		frame.setBounds(100, 100, 697, 447);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		SpringLayout springLayout = new SpringLayout();
		frame.getContentPane().setLayout(springLayout);
		
		JTextArea chatLogArea = new JTextArea();
		chatLogArea.setEditable(false);
		springLayout.putConstraint(SpringLayout.NORTH, chatLogArea, 10, SpringLayout.NORTH, frame.getContentPane());
		springLayout.putConstraint(SpringLayout.WEST, chatLogArea, 10, SpringLayout.WEST, frame.getContentPane());
		frame.getContentPane().add(chatLogArea);
		
		inputField = new JTextField();
		inputField.addKeyListener(new KeyAdapter() {
			@Override
			public void keyPressed(KeyEvent e) {
				if(e.getKeyCode() == KeyEvent.VK_ENTER){
					System.out.println("enter pressed");
					controller.sendMessage(inputField.getText() );
					inputField.setText( "" );
					inputField.requestFocus();
				}
			}
		});
		springLayout.putConstraint(SpringLayout.WEST, inputField, 10, SpringLayout.WEST, frame.getContentPane());
		springLayout.putConstraint(SpringLayout.SOUTH, inputField, -10, SpringLayout.SOUTH, frame.getContentPane());
		frame.getContentPane().add(inputField);
		inputField.setColumns(10);
		
		sendButton = new JButton("Send");
		springLayout.putConstraint(SpringLayout.SOUTH, chatLogArea, -6, SpringLayout.NORTH, sendButton);
		springLayout.putConstraint(SpringLayout.EAST, chatLogArea, 0, SpringLayout.EAST, sendButton);
		springLayout.putConstraint(SpringLayout.EAST, sendButton, -173, SpringLayout.EAST, frame.getContentPane());
		springLayout.putConstraint(SpringLayout.SOUTH, sendButton, -10, SpringLayout.SOUTH, frame.getContentPane());
		springLayout.putConstraint(SpringLayout.EAST, inputField, -6, SpringLayout.WEST, sendButton);
		frame.getContentPane().add(sendButton);
		
		JPanel infoPanel = new JPanel();
		springLayout.putConstraint(SpringLayout.NORTH, infoPanel, 10, SpringLayout.NORTH, frame.getContentPane());
		springLayout.putConstraint(SpringLayout.WEST, infoPanel, 6, SpringLayout.EAST, chatLogArea);
		springLayout.putConstraint(SpringLayout.SOUTH, infoPanel, 0, SpringLayout.SOUTH, inputField);
		springLayout.putConstraint(SpringLayout.EAST, infoPanel, 163, SpringLayout.EAST, chatLogArea);
		frame.getContentPane().add(infoPanel);
	}
}
