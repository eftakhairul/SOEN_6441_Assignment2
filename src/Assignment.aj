import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public aspect Assignment {

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
	before(Object p, Object t) : call (* *(..)) 
	   		   && !within(Assignment)
	   		   && !cflow(call (* java.*.*.*(..)))
	   		   && this(p)
	   		   && target(t) {
		
		File textFileName = new File("call.txt");
		try {
			// Permission Given
			textFileName.setWritable(true);
			FileWriter fileWriter 		  = new FileWriter(textFileName, true);
			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);

			// Wring to text
			bufferedWriter.write( "calls("+p.hashCode()+","+p.getClass().getName()+","+t.hashCode()+","+t.getClass().getName()+","+System.currentTimeMillis() / 1000L + ")");
			
			bufferedWriter.newLine();
			bufferedWriter.close();
		} catch (IOException e) {
			System.out.println("Something went wrong while writing in text file.");
		}
		
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
			bufferedWriter.write("termination('" +thisJoinPoint.getSignature()+"'," + thisEnclosingJoinPointStaticPart.hashCode()+"," +System.currentTimeMillis() / 1000L + ")");			
			bufferedWriter.newLine();
			bufferedWriter.close();
		} catch (IOException e) {
			System.out.println("Something went wrong while writing in text file.");
		}
	}	
}