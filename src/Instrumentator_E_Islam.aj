import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public aspect Instrumentator_E_Islam
{	
	//Task 1
	before() : call(*.new(..)) &&
			   !within(Instrumentator_E_Islam) &&
			   !cflow(call(java.*.*.new(..))) {

		int instantId 	   		= thisJoinPoint.hashCode();
		String instantType      = thisJoinPoint.getSignature().getDeclaringTypeName();
		Object instantSignature = thisJoinPoint.getSignature();
		long time 				= System.currentTimeMillis() / 1000L;
		
		String message = "instance(" + instantId + 
						 ", '" + instantType +
						 "', '" + instantSignature + 
						 "', " + time + ").";
		
		this.logger(message, "instantiations.txt");		
	}	
	
	//Task 2
	before(Object sender, Object receiver) : call (* *(..)) 
									   		 && !within(Instrumentator_E_Islam)
									   		 && !cflow(call (* java.*.*.*(..)))
									   		 && this(sender)
									   		 && target(receiver) {
		long time = System.currentTimeMillis() / 1000L;
		
		String message = "calls(" + sender.hashCode() + 
				         ", " + sender.getClass().getName() + 
				         ", " + receiver.hashCode() + 
				         ", " + receiver.getClass().getName() + 
				         ", '" + thisJoinPoint.getSignature() + 
				         "', " + time + ").";	
		
		this.logger(message, "calls.txt");
	}	
	
	//Task 3
	before(Object p) : (execution (* *(..)) || adviceexecution())
	  		           && !within(Instrumentator_E_Islam)
	  		           && !cflow(execution (* java.*.*.*(..)))
	  		           && this(p) {
		
		int executingObjectId      = thisJoinPoint.hashCode();
		String executingObjectType = thisJoinPoint.getSignature().getDeclaringTypeName();
		Object methodSignature     = thisJoinPoint.getSignature();
		long time 				   = System.currentTimeMillis() / 1000L;
		
		String message = "execution(" + executingObjectId + 
						 ", '" + executingObjectType + 
						 "', '" + methodSignature + 
						 "', " + time + ").";	
		
		this.logger(message, "executions.txt");
	}	
	
	//Task 4
	after(Object p) : (execution (* *(..)) || adviceexecution())
	  		          && !within(Instrumentator_E_Islam)
	  		          && !cflow(execution (* java.*.*.*(..)))
	  		          && this(p) {
		
		Object instanceMethod 		= thisJoinPoint.getSignature();
		int executingInstanceId  	= thisJoinPoint.hashCode();
		long time 				    = System.currentTimeMillis() / 1000L;
		
		String message = "termination('" +instanceMethod+
				         "', " + executingInstanceId +
				         ", " + time + ").";
		
		this.logger(message, "terminations.txt");
	}
	
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
}