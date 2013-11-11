import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public aspect Assignment {
	
	public void logger(String message, String fileName) {
		
		File textFileName = new File(fileName);
		try {
			// Permission Given
			textFileName.setWritable(true);
			FileWriter fileWriter 		  = new FileWriter(textFileName, true);
			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);

			// Wring to text
			bufferedWriter.write(message);
			
			bufferedWriter.newLine();
			bufferedWriter.close();
		} catch (IOException e) {
			System.out.println("Something went wrong while writing in text file.");
		}		
	}

	//Task 1
	before() : initialization (*.new(..)) 
			  && !within(Assignment)
			  && !cflow(initialization (java.*.*.new(..))) {

		int instantId 	   		= thisJoinPoint.hashCode();
		String instantType      = thisJoinPoint.getSignature().getDeclaringTypeName();
		Object instantSignature = thisJoinPoint.getSignature();
		long time 				= System.currentTimeMillis() / 1000L;

		File textFileName = new File("instantiations.txt");
		try {
			// Permission Given
			textFileName.setWritable(true);
			FileWriter fileWriter 		  = new FileWriter(textFileName, true);
			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);

			// Wring to text
			bufferedWriter.write("instance(" + instantId + 
								 ",'" + instantType +
								 "',' " + instantSignature + 
								 "'," + time + ")");
			
			bufferedWriter.newLine();
			bufferedWriter.close();
		} catch (IOException e) {
			System.out.println("Something went wrong while writing in text file.");
		}
	}
	
	
	//Task 2
	before(Object sender, Object receiver) : call (* *(..)) 
									   		 && !within(Assignment)
									   		 && !cflow(call (* java.*.*.*(..)))
									   		 && this(sender)
									   		 && target(receiver) {
		
		String message = "calls("+sender.hashCode()+","+sender.getClass().getName()+","+receiver.hashCode()+","+receiver.getClass().getName()+","+ thisJoinPoint.getSignature()+","+System.currentTimeMillis() / 1000L + ")";		
		this.logger(message, "call.txt");
		
		
		
	}
	
	
	
	
	//Task 3
	before() : (execution (* *(..)) || adviceexecution())
	  		   && !within(Assignment)
	  		   && !cflow(execution (* java.*.*.*(..))) {
		
		int executingObjectId   = thisJoinPoint.hashCode();
		String executingObjectType = thisJoinPoint.getSignature().getDeclaringTypeName();
		Object methodSignature     = thisJoinPoint.getSignature();
		long time 				   = System.currentTimeMillis() / 1000L;
		
		File textFileName = new File("execution.txt");
		try {
			// Permission Given
			textFileName.setWritable(true);
			FileWriter fileWriter 		  = new FileWriter(textFileName, true);
			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);

			// Wring to text
			bufferedWriter.write("execution(" + "'" + executingObjectId + 
								"','" + executingObjectType + 
								"','" + methodSignature + 
								"'," +time + ")");
			
			bufferedWriter.newLine();
			bufferedWriter.close();
		} catch (IOException e) {
			System.out.println("Something went wrong while writing in text file.");
		}
	}	
	
	//Task 4
	after() : (execution (* *(..)) || adviceexecution())
	  		   && !within(Assignment)
	  		   && !cflow(execution (* java.*.*.*(..))) {
		
//		int executingObjectId      = thisJoinPoint.hashCode();
//		String executingObjectType = thisJoinPoint.getSignature().getDeclaringTypeName();
//		Object methodSignature     = thisJoinPoint.getSignature();
//		long time 				   = System.currentTimeMillis() / 1000L;
		
		File textFileName = new File("terminations.txt");
		try {
			// Permission Given
			textFileName.setWritable(true);
			FileWriter fileWriter 		  = new FileWriter(textFileName, true);
			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);

			// Wring to text
			bufferedWriter.write("termination('" +thisJoinPoint.getSignature()+"'," + thisJoinPoint.hashCode()+"," +System.currentTimeMillis() / 1000L + ")");			
			bufferedWriter.newLine();
			bufferedWriter.close();
		} catch (IOException e) {
			System.out.println("Something went wrong while writing in text file.");
		}
	}	
}